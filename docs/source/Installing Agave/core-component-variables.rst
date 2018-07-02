Core Components
---------------
The following tables describe variables for use with the Ansible installer that can be used to configure the Core components:

.. list-table:: Core component Playbook variables
   :widths: 30 15 55
   :header-rows: 1

   * - Variable
     - Type
     - Description
   * - **deploy_core_apis**
     - bool
     - | Whether to deploy the front-end core APIs. Set
       | to False when running playbooks that impact
       | multiple servers and you do not want to modify
       | the core APIs.
   * - **deploy_core_apis_a_deployment**
     - bool
     - | The core APIs deploy in an A/B configuration to
       | minimize downtime during updates. Set this to
       | true to deploy the "A" set. One of "A" or "B"
       | should be set to true.
   * - **deploy_core_apis_b_deployment**
     - bool
     - | The core APIs deploy in an A/B configuration to
       | minimize downtime during updates. Set this to
       | true to deploy the "B" set. One of "A" or "B"
       | should be set to true.
   * - **agave_core_workers_only**
     - bool
     - | Whether to deploy the core workers. Using this
       | feature you can deploy only the workers.
   * - **kill_core_containers**
     - bool
     - | Whether to remove any existing core containers
       | when deploying.
   * - **agave_core_version**
     - string
     - | Version of the core services to deploy
       | (e.g. 2.2.6).
   * - **agave_core_hostname**
     - string
     - | Hostname for the core services.
   * - **core_deploy_ssl_certs**
     - bool
     - | Whether or not to use custom SSL certs for core
       | services. If False, deployer will use stock (self-
       | signed) certs for core services. In general, this
       | is not an issue since the core services are not
       | directly exposed to external users (SNI for
       | external requests happens in the auth layer).
       | However, if you have the need to export core
       | services and/or terminate SSL in the core layer,
       | set this to True and provide ssl certs using the
       | **agave_core_ssl_cert**, **agave_core_ssl_key**
       | and **agave_core_ca_cert**.
   * - **agave_core_ssl_cert**
     - string
     - | Path in the container to core ssl cert. This file
       | should be placed in the
       | ``roles/agave_core/files/core-apis-ssl``
       | directory.
   * - **agave_core_ssl_key**
     - string
     - | Path in the container to core ssl cert key. This
       | file should be placed in the
       | ``roles/agave_core/files/core-apis-ssl``
       | directory.
   * - **agave_core_ca_cert**
     - string
     - | Path in the container to core ssl CA cert. This
       | file should be placed in the
       | ``roles/agave_core/files/core-apis-ssl``
       | directory.
   * - **agave_core_java_mem_limit**
     - string
     - | Memory limit for each of the Java core service
       | containers.
   * - **agave_core_allow_relay_transfer**
     - string
     - | Whether to allow relay transfers from the files
       | and transforms services.
   * - **agave_core_max_relay_transfer_size**
     - string
     - | Max transfer size, in GB.
   * - **agave_core_max_page_size**
     - string
     - | Maximum number of results to return in a single
       | request.
   * - **agave_core_default_page_size**
     - string
     - | Default number of results to return in a single
       | request when the *limit* query parameter has
       | not been passed in the HTTP request.
   * - **agave_core_iplant_proxy_service**
     - string
     - | Resolvable address of the core proxy. For single
       | core server deploys, should point to the core
       | server.
   * - **core_docker_private_registry**
     - string
     - | (Optional) Address of private registry from which
       | to pull the Docker images.
   * - **core_docker_registry_account**
     - string
     - | (Optional) Username to use to access the private
       | registry.
   * - **deploy_core_default_templates**
     - string
     - | Whether to use the default core compose
       | templates. Set to False to use a git repository
       |  of compose files or True to use the default
       | templates.
       |
       | *Note:This variable must be set in the*
       | ``core_configs.yml`` **AS WELL AS** *in the inventory*
       | *file for each core host. See the* ``staging_hosts``
       | *file for an example.*
   * - **core_compose_repo_uri**
     - string
     - | URI of the git repository containing the core
       | compose files (e.g.,
       | `git@gitlab.com:devops/core-compose.git`)
   * - **core_compose_repo_key_file**
     - string
     - | File name for the SSH key to use to access the
       | git repository.
       | *Note: It is assumed that this file is in
       | ``roles/agave_core_compose_repo/files``
       | so it should be mounted there.
   * - **core_compose_repo_name**
     - string
     - | The name of the git repository containing the
       | core compose files (e.g. "core-compose").
   * - **core_compose_repo_path**
     - string
     - | Relative path inside the git repo to use for the
       | compose files. Note: Set this variable for each
       | core host in the inventory file.


   * - **agave_core_realtime_service_type**
     - string
     - | Type of backend service to use for realtime API.
       | Currently value "fanout", "pushpin", and "none"
       | are supported.
   * - **agave_core_realtime_service**
     - string
     - | Addressable location of the backend streaming
       | server for realtime API.
   * - **agave_core_realtime_service_realm_id**
     - string
     - | Realm id when using the fanout backend.
   * - **agave_core_realtime_service_realm_key**
     - string
     - | Realm key when using the fanout backend.

   * - **mysql_core_host**
     - string
     - | Host or ip of the core services MySQL database.
   * - **mysql_core_port**
     - string
     - | Port of the core services MySQL database.
   * - **mysql_core_user**
     - string
     - | Username used to connect to the core services
       | MySQL database.

   * - **agave_core_metadata_db_host**
     - string
     - | Mongo host for core services.
   * - **agave_core_metadata_db_port**
     - string
     - | Mongo port for core services.
   * - **agave_core_metadata_db_user**
     - string
     - | Mongo user for core services.

   * - **agave_core_notification_queue**
     - string
     - | Beanstalk queue for core services. (e.g.
       | "staging.notifications.queue")
   * - **agave_core_notification_topic**
     - string
     - | Beanstalk topic for core services. (e.g.
       | "staging.notifications.topic")
   * - **agave_core_messaging_host**
     - string
     - | Host for Beanstalk server.
   * - **agave_core_messaging_port**
     - string
     - | Port for Beanstalk server.

   * - **agave_core_smtps_provider**
     - string
     - | Type of SMTP server to use (for sending
       | notification emails, etc.). Use "sendgrid"
       | to enable emails sent via the SendGrid API,
       | requires account info).
   * - **agave_core_smtps_host**
     - string
     - | Host for the SMTP server. (Use
       | "smtp.sendgrid.net" if sendgrid provider is
       | configured.)
   * - **agave_core_smtps_port**
     - string
     - | Port for the SMTP server.
   * - **agave_core_smtps_auth**
     - bool
     - | Whether auth is required.
   * - **agave_core_smtps_user**
     - string
     - | Username to use when authenticating to the
       | mail server.

   * - **core_deploy_stats**
     - bool
     - | Whether to deploy the stats container.
       | *Note: This container is currently optimized*
       | *for Agave's production environment and*
       | *requires a Pingdom account, among other*
       | *configurations.*

