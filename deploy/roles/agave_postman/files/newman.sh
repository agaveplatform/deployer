#!/bin/bash

set -o errexit #abort if any command fails
me=$(basename "$0")

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# pull latest images
PHP_IMAGE=${PHP_IMAGE:-'bitnami/php-fpm:latest'}
NEWMAN_IMAGE=${NEWMAN_IMAGE:-'postman/newman_ubuntu1404:3.2.0'}

help_message="\
Usage: $me [<options>] TENANT_ID
Runs Agave Platform integration tests against the Science APIs and publishes a
report summary to Slack. Options exist for running directly against the backend,
running tests against a single service, and status results posted to the
agave-slackops Slack channel.

Options:

  -s, --service            The name of an Agave Science API service to run the tests on.
                           If specified, only the tests against this service will be run.
      --skip-frontend      If present the tests will be run against the backend services,
                           bypassing the tenant APIM, with a self-generated JWT.
      --notify-slack [url] The Slack Incoming Webhook URL to which the test result summary will be
                           posted. See https://my.slack.com/services/new/incoming-webhook/ for more info.
      --add-host [host:ip] Any additional hosts to add into the docker containers.
  -t, --dry-run            Run the filters and set the environment, but skip actual test run
  -h, --help               Show this help information.
  -v, --verbose            Increase script verbosity.
  -d, --debug              Enable debug logging on the HTTP requests.
  "

function err() {
    echo "$@" >&2 ;

    cleanup_temp_files

    exit 1;
}

function cleanup_temp_files() {
  (( $verbose )) && echo "Removing temp filtered files"
  rm -rf tmp
}

function parse_args() {

  extra_hosts=()

  # Parse arg flags
  # If something is exposed as an environment variable, set/overwrite it
  # here. Otherwise, set/overwrite the internal variable instead.
   while : ; do
    if [[ $1 = "-h" || $1 = "--help" ]]; then
      echo "$help_message"
      return 0
    elif [[ $1 = "-v" || $1 = "--verbose" ]]; then
      verbose=1
      shift
    elif [[ $1 = "-d" || $1 = "--debug" ]]; then
      debug=1
      shift
    elif [[ ( $1 = "-s" || $1 = "--service" ) && -n $2 ]]; then
      core_service=$2
      shift 2
    elif [[ $1 = "--skip-frontend"  ]]; then
      skip_frontend=1
      shift
    elif [[ $1 = "--notify-slack"  ]]; then
      notify_slack=1
      if [[ -n $2 ]]; then
        slack_webhook_url=$2
        shift 2
      else
        echo "Please provide a Slack incoming webhook url where the test results should be posted.
See https://my.slack.com/services/new/incoming-webhook/ for more information." 1>&2
        die 1
      fi

    elif [[ $1 = "-t" || $1 = "--dry-run"  ]]; then
      dry_run=1
      shift
    elif [[ $1 = "--add-host" ]] && [[ -n "$2" ]]; then
      extra_hosts+=( "$1 $2" )
      shift 2
    else
      break
    fi
  done

  # Set internal option vars from the environment and arg flags. All internal
  # vars should be declared here, with sane defaults if applicable.


  if [[ -z "$1" ]]; then
    echo "No tenant provided." >&2
    echo "$help_message"
    return 1
  else
    TENANT="${1}"
  fi

}



function main() {
    local _COLLECTION  _ENVIRONMENT FILTERED_COLLECTION FILTERED_ENVIRONMENT _ITERATION_DATA

    parse_args "$@"

    if [[ ! -d "tmp" ]]; then
      mkdir ./tmp
    fi

    # switch to jwt environment if skipping frontend
    if (( $skip_frontend )); then
        (( $verbose )) && echo "Front end request will be skipped ...";
        _ENVIRONMENT="environments/$TENANT.jwt.postman_environment"
        FILTERED_ENVIRONMENT="tmp/$TENANT.jwt.postman_environment"
    else
        _ENVIRONMENT="environments/$TENANT.postman_environment"
        FILTERED_ENVIRONMENT="tmp/$TENANT.postman_environment"
    fi

    # ensure environment file is there
    if [[ ! -e "$_ENVIRONMENT" ]]; then
        err "No environment found for $TENANT. Please provide a valid tenant environment to run the tests against."
    fi

    # ensure collection is present
    _COLLECTION="collections/agave-core-services.postman_collection.json"
    if [[ ! -e "$_COLLECTION" ]]; then
        err "No collection found to run at $_COLLECTION."
    fi

    FILTERED_COLLECTION="tmp/agave-core-services.postman_collection.json"

    # ensure newman iteration data is present
    _ITERATION_DATA="config/newman_data.json"
    if [[ ! -e "$_ITERATION_DATA" ]]; then
        err "No iteration data found to run at $_ITERATION_DATA."
    fi

    # if we are skipping the frontend, update the environment accordingly
    if (( $skip_frontend )); then
        # update the environment setting SKIP_FRONTEND=true
        #cat "$_ENVIRONMENT" | jq '.values |= map((select(.key == "SKIP_FRONTEND") | .value) |= "true")' > "$FILTERED_ENVIRONMENT"
        cat "$_ENVIRONMENT" | sed 's/%%SKIP_FRONTEND%%/true/' > "${FILTERED_ENVIRONMENT}"
    else
        # update the environment ensuring SKIP_FRONTEND=false
        #cat "$_ENVIRONMENT" | jq '.values |= map((select(.key == "SKIP_FRONTEND") | .value) |= "")' > "$FILTERED_ENVIRONMENT"
        cat "$_ENVIRONMENT" | sed 's/%%SKIP_FRONTEND%%//' > "${FILTERED_ENVIRONMENT}"
    fi

    # if a service value is given, update the environment to use that value.
    if [[ -n "$core_service" ]]; then
        if [[ -n "$(grep "${core_service}::Start" $_COLLECTION)" ]]; then
            first_test="${core_service}::Start"
        elif [[ -n "$(grep "${core_service} setup::" $_COLLECTION)" ]]; then
            first_test=$(grep "${core_service} setup::" $_COLLECTION | head -n 1 | sed 's/.*"name": //g' | sed 's/,//g' | sed 's/"//g' )
        elif [[ -n "$(grep "${core_service}::" $_COLLECTION)" ]]; then
            first_test=$(grep "${core_service}::" $_COLLECTION | head -n 1 | sed 's/.*"name": //g' | sed 's/,//g' | sed 's/"//g' )
        fi

        if [[ -z "$first_test" ]]; then
            err "No postman tests found for service $core_service"
        else
            (( $verbose )) && echo "Restricting tests to the $core_service API";
            (( $verbose )) && echo "First test will be $first_test";
            # update the environment with the first service test to run
            sed -i.0 's/%%SKIP_TO_TEST%%/'"${first_test}"'/g'  $FILTERED_ENVIRONMENT
            #cat "$_ENVIRONMENT" | jq --arg t "${first_test}" '.values |= map((select(.key == "SKIP_TO_TEST") | .value) |= $t)' > "$FILTERED_ENVIRONMENT"
        fi
    else
        # update the environment with an empty first service test to run
        sed -i.0 's/%%SKIP_TO_TEST%%//' "${FILTERED_ENVIRONMENT}"
        #cat "$_ENVIRONMENT" | jq '.values |= map((select(.key == "SKIP_TO_TEST") | .value) |= "")' > "$FILTERED_ENVIRONMENT"
    fi


    # Update the global timestamp used to generate unique resource IDs in the tests.
    _TS=$(date +%s)
    (( $verbose )) && echo "Setting environment TEST_DATE to $_TS";
    sed -i.0 's/%%TEST_DATE%%/'$_TS'/' "${FILTERED_ENVIRONMENT}"

    resolve_multipart_upload_template_variables $_TS

    ######################################
    #    DO NOT EDIT BELOW THIS LINE     #
    ######################################


   # Since we are not adjusting file paths, copy over the collection explicitly
    cp -f "${_COLLECTION}" "${FILTERED_COLLECTION}"

    # touch the output files so we don't have to adjust their permissions
    mkdir -p reports
    touch reports/newman-report.json
    touch reports/newman-report.xml
    touch reports/newman-report.html

    # exit here if we're done with the dry run.
    if (( $dry_run )); then
      exit 0
    fi

    # if we're posting to slack, we call the newman-to-slack script
    if (( $notify_slack )); then

        if (( $debug )); then
            (( $verbose )) && echo "Enabling verbose debugging ...";
            export NODE_DEBUG=http,request,net
        fi

        (( $verbose )) && echo "Starting newman-to-slack runner ...";

        lib/newman-to-slack.sh \
                -v -v -v \
                -a "--iteration-data $_ITERATION_DATA --insecure --timeout-request 60000 --disable-unicode --reporters cli,html,json,junit --reporter-json-export reports/newman-report.json --reporter-junit-export reports/newman-report.xml --reporter-html-export reports/newman-report.html" \
                --environment "$FILTERED_ENVIRONMENT" \
                --webhook $slack_webhook_url \
                -c $FILTERED_COLLECTION || true

    # if we are not posting to slack, we run the collection manually in a docker container
    else

        echo "docker run \
             --rm=true \
             -l newman -l $TENANT \
             $([[ -n "$extra_hosts" ]] && echo "${extra_hosts}" || echo "") \
             -v ${PWD}:/etc/newman \
             -i \
             -e "NODE_DEBUG=$( (( debug )) && echo "http,request,net" || echo "false" )" \
             $NEWMAN_IMAGE run \
             --timeout-request 60000 \
             --delay-request 25 \
             --insecure \
             --no-color \
             --reporters cli,html,json,junit \
             --reporter-json-export reports/newman-report.json \
             --reporter-junit-export reports/newman-report.xml \
             --reporter-html-export reports/newman-report.html \
             --environment "$FILTERED_ENVIRONMENT" \
             --iteration-data $_ITERATION_DATA \
             $FILTERED_COLLECTION"

        (( $verbose )) && echo "Starting docker newman runner ...";
        docker run \
             --rm=true \
             -l newman -l $TENANT \
             $([[ -n "$extra_hosts" ]] && echo "${extra_hosts}" || echo "") \
             -v ${PWD}:/etc/newman \
             -i \
             -e "NODE_DEBUG=$( (( debug )) && echo "http,request,net" || echo "false" )" \
             $NEWMAN_IMAGE run \
             --timeout-request 60000 \
             --delay-request 25 \
             --insecure \
             --no-color \
             --reporters cli,html,json,junit \
             --reporter-json-export reports/newman-report.json \
             --reporter-junit-export reports/newman-report.xml \
             --reporter-html-export reports/newman-report.html \
             --environment "$FILTERED_ENVIRONMENT" \
             --iteration-data "$_ITERATION_DATA" \
             "$FILTERED_COLLECTION"

    fi

    cleanup_temp_files
}

function resolve_multipart_upload_template_variables () {
  # get the username from the environment file which was filtered
  # prior to this function call
  TENANT_CODE=$(cat "$FILTERED_ENVIRONMENT" | jq -r '.values[] | select(.key == "TENANT_CODE") | .value' )
  TENANT_USERNAME=$(cat "$FILTERED_ENVIRONMENT" | jq -r '.values[] | select(.key == "USERNAME") | .value' )
  TENANT_USER_EMAIL=$(cat "$FILTERED_ENVIRONMENT" | jq -r '.values[] | select(.key == "USER_EMAIL") | .value' )
  TEST_DATE=${_TS}
  STORAGE_SYSTEM_ID="postman-test-storage-${TEST_DATE}"
  COMPUTE_SYSTEM_ID="postman-test-compute-${TEST_DATE}"
  TEST_DIR_ENCODED="postman-test-${TENANT_CODE}-${TENANT_USERNAME}-${TEST_DATE}-apps"
  APP_ID="wc-${TEST_DATE}-test"
  for tpl in `find data -name "*.json"`; do
    (( $verbose )) && echo "Processing data template file $tpl"

    tmpdir="tmp/$(dirname $tpl)"
    # make sure temp data directory is there
    if [[ ! -d "$tmpdir" ]]; then
      mkdir -p "$tmpdir"
    fi

    cat "$tpl" | sed 's/{{STORAGE_SYSTEM_ID}}/'${STORAGE_SYSTEM_ID}'/g' > "tmp/$tpl"
    sed -i.0 's/{{COMPUTE_SYSTEM_ID}}/'${COMPUTE_SYSTEM_ID}'/g' "tmp/$tpl"
    sed -i.0 's/{{TEST_DIR_ENCODED}}/'${TEST_DIR_ENCODED}'/g' "tmp/$tpl"
    sed -i.0 's/{{USERNAME}}/'${TENANT_USERNAME}'/g' "tmp/$tpl"
    sed -i.0 's/{{USER_EMAIL}}/'${TENANT_USER_EMAIL}'/g' "tmp/$tpl"
    sed -i.0 's/{{APP_ID}}/'${APP_ID}'/g' "tmp/$tpl"
    sed -i.0 's/{{TEST_DIR_ENCODED}}/'${TEST_DIR_ENCODED}'/g' "tmp/$tpl"
    sed -i.0 's/{{TEST_DATE}}/'${_TS}'/g' "tmp/$tpl"
  done
}

main "$@"
