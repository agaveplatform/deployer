Core Components
---------------
The following tables describe variables for use with the Ansible installer that can be used to configure the Core components:

.. list-table:: Core component Playbook variables
   :widths: 30 15 55
   :header-rows: 1

   * - Variable
     - Type
     - Description
   * - **tenant_id**
     - string
     - | A unique id for this tenant.
       | *Note: This will be replaced by the ``agave_tenant_id``*
       | *field in the near future. Both are currently *
       | *required.*
   * - **agave_tenant_id**
     - string
     - | A unique id for this tenant.
       | *Note: This will be replace the ``tenant_id``*
       | *field in the near future. Both are currently *
       | *required.*
   * - **tenant_public_domain_or_ip**
     - string
     - | The public domain name or ip address of the
       | auth server. This is the address you will use
       | to connect to your installation.
       | *required.*
   * - **host**
     - string
     - | The public domain that the platform should listen
       | to  API requests on. For example, if this value is
       | ``api.example.org``, then the core apps service
       | will be available at ``https://api.example.org/apps/v2``.
       |
       | *Note: This will be replace by the *
       | *``tenant_public_domain_or_ip`` field in the near future.*
       | *required.*

   * - **mysql_core_host**
     - string
     - | Host or ip of the core services MySQL database.
   * - **mysql_core_port**
     - string
     - | Port of the core services MySQL database.

   * - **agave_core_messaging_provider**
     - string
     - | The type of message queue to use.
       | Default: beanstalk
   * - **agave_core_messaging_host**
     - string
     - | Host for message queue server.
       | Default: messaging_host
   * - **agave_core_messaging_port**
     - string
     - | Port for message queue server.
       | Default: messaging_port


   * - **agave_core_smtps_provider**
     - string
     - | Type of SMTP server to use (for sending
       | notification emails, etc.). Use "sendgrid"
       | to enable emails sent via the SendGrid API,
       | requires account info).
       | Default: sendgrid
   * - **agave_core_smtps_host**
     - string
     - | Host for the SMTP server. (Use
       | "smtp.sendgrid.net" if sendgrid provider is
       | configured.)
       | Default: smtp.sendgrid.net
   * - **agave_core_smtps_port**
     - string
     - | Port for the SMTP server.
       | Default: 587
   * - **agave_core_smtps_auth**
     - bool
     - | Whether auth is required.
       | Default: true
   * - **agave_core_smtps_from_name**
     - string
     - | From name used in email communications.
       | Default: Agave Notifications
   * - **agave_core_smtps_from_address**
     - string
     - | From address used in email communications.
       | Default: no-reply@agaveplatform.org


   * - **deploy_core_apis**
     - bool
     - | Whether to deploy the front-end core APIs. Set
       | to False when running playbooks that impact
       | multiple servers and you do not want to modify
       | the core APIs.
       | Default: true
   * - **kill_core_containers**
     - bool
     - | Whether to kill and restart the core containers
       | when deploying. Setting to false allows for
       | configuration updates and rolling deployments
       | rather than a full teardown and rebuild.
       | Default: false

   * - **core_docker_private_registry**
     - string
     - | (Optional) Address of private registry from which
       | to pull the Docker images.
       | Default:
   * - **core_docker_registry_account**
     - string
     - | (Optional) Username to use to access the private
       | registry.
       | Default:



   * - **agave_core_api_only**
     - bool
     - | Whether to only deploy the core apis. Using this
       | feature you can deploy only the frontend API
       | to gain horizontal scaling while reducing your
       | memory consumption on the host.
       | Default: false
   * - **agave_core_workers_only**
     - bool
     - | Whether to only deploy the core workers. Using
       | this feature you can deploy worker only hosts
       | to add capacity and scale throughput.
       | Default: false

   * - **agave_core_version**
     - string
     - | Version of the core services to deploy
       | Default: 2.2.6
   * - **agave_core_hostname**
     - string
     - | Externally resolvable public hostname where the
       | core science API reverse proxy lives.
       | Default: api.sandbox.agaveplatform.org
   * - **agave_core_proxy_http_port**
     - int
     - | Port on which the proxy will serve external http
       | traffic. Defaults to 80. Should match the value of
       | **core_api_port** when **core_api_protocol** is
       | set to ``http`` in the auth component variables.
   * - **agave_core_proxy_https_port**
     - int
     - | Port on which the proxy will serve external https
       | traffic. Defaults to 443. Should match the value of
       | **core_api_port** when **core_api_protocol** is
       | set to ``https`` in the auth component variables.
   * - **agave_proxy_core_ip**
     - string
     - | Hostname for the core services.
       | Default: core api host ip address
   * - **agave_core_iplant_proxy_service**
     - string
     - | Resolvable address of the core proxy. For single
       | core server deploys, should point to the core
       | server.
       | Default: "http://<core api host ip address>"
   * - **agave_core_log_service**
     - string
     - | Internally resolvable address to the logging API
       | Default: "http://<core api host ip address>/logging"

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
       | Default: false
   * - **agave_core_ssl_cert**
     - string
     - | Path in the container to core ssl cert. This file
       | should be placed in the
       | ``roles/agave_core/files/core-apis-ssl``
       | directory.
       | Default: api.sandbox.agaveplatform.org.crt
   * - **agave_core_ssl_key**
     - string
     - | Path in the container to core ssl cert key. This
       | file should be placed in the
       | ``roles/agave_core/files/core-apis-ssl``
       | directory.
       | Default: api.sandbox.agaveplatform.org.key
   * - **agave_core_ca_cert**
     - string
     - | Path in the container to core ssl CA cert. This
       | file should be placed in the
       | ``roles/agave_core/files/core-apis-ssl``
       | directory.
       | Default:
   * - **core_deploy_httpd_balancer**
     - bool
     - | Whether or not to use an apache loadbalancer
       | on the core host in leu of a reverse proxy.
       | This enables an A/B HA deployment similar to
       | that done by the APIM deployment, but generally
       | suffers when services have slow response times
       | caused by remote system requests with
       | noticeable latency.
       | Default: false


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


   * - **agave_core_java_mem_limit**
     - string
     - | The default memory limit set for each of the
       | Java core service containers. This is over-
       | ridden by each individual service.
       | Default: 2048m
   * - **agave_core_php_mem_limit**
     - string
     - | The default memory limit set for each of the
       | PHP core service containers. This is over-
       | ridden by each individual service.
       | Default: 1024m


   * - **agave_core_allow_relay_transfer**
     - bool
     - | If true, smaller files will be proxied with
       | a GET and PUT in all data transfers. Otherwise,
       | they will be proxied in memory via streaming
       | buffer copies. The former can be much faster
       | for bulk file operations and cross-protocol
       | transfers where dynamic window sizing and
       | parallel/striped transfers
       | Default: false
   * - **agave_core_max_relay_transfer_size**
     - int
     - | Max file size in GB that can be relayed. Any
       | file larger than this will be copied in memory
       | through streaming buffers. If this is enabled,
       | then the host must have sufficient disk for every
       | worker process that moves data to simultaneously
       | be copying data.
       | Default: 1


   * - **agave_core_max_page_size**
     - int
     - | Maximum number of results to return in a single
       | request.
       | Default: 250
   * - **agave_core_default_page_size**
     - int
     - | Default number of results to return in a single
       | request when the *limit* query parameter has
       | not been passed in the HTTP request.
       | Default: 100


   * - **agave_core_drain_all_queues**
     - bool
     - | If true, no workers will be started on the
       | target host. This effectively turns a container
       | into an API only container. If set to true,
       | there must be a worker container with this
       | value set to true or no async tasks such as
       | job submission, monitoring, notifications, etc
       | will be processed.
       | Default: false
   * - **agave_core_dedicated_tenant_id**
     - string
     - | When running multiple denants within a single
       | deployment, setting this value to a tenant
       | code will force all core components with this
       | setting to only accept tasks for the named
       | tenant. Negation is also supported by
       | prepending the tenant code with an exclamation
       | mark.
       |
       | *Note: Setting this value will not preclude*
       | *other tenants from accepting work for this*
       | *tenant.*
       | Default:
   * - **agave_core_dedicated_system_ids**
     - string
     - | Set to a comma-separated list of Agave
       | systems to restirct all components with this
       | setting to restrict work to the named list.
       | Negation is supported by prepending the tenant
       | code with an exclamation mark. Exclusions
       | will take priority over inclusions.
       |
       | *Note: Setting this value will not preclude*
       | *other tenants from accepting work for this*
       | *tenant.*
       | Default:
   * - **agave_core_dedicated_user_ids**
     - string
     - | Set to a comma-separated list of Agave
       | usernames to restirct all components with this
       | setting to restrict work to the named users.
       | Negation is supported by prepending the tenant
       | code with an exclamation mark. Exclusions
       | will take priority over inclusions.
       |
       | *Note: Setting this value will not preclude*
       | *other tenants from accepting work for this*
       | *tenant.*
       | Default:

   * - **agave_core_jobs_mem_limit**
     - string
     - | Max memory for the jobs container. This
       | should be at least 8GB for a worker.
       | API only deployment can be significantly
       | less. This value Will bound xmx in the
       | JVM was well. General rule of thumb is
       | 0.5 core and 1GB memory per data-centric
       | task per container. High job rates can
       | grow JVM system utilization upwards of
       | 1CPU and 2GB memory per transfer task,
       | so plan accordingly.
       |
       | If your resources allow, set
       | agave_core_jobs_mem_limit to False to
       | uncap the memory on this container.
       | Default: 8192m
   * - **core_deploy_jobs**
     - bool
     - | Should the Jobs container be deployed.
       | Default: true
   * - **agave_core_job_max_staging_tasks**
     - int
     - | The maximum number of job statging
       | tasks to run concurrently.
       | Default: 5
   * - **agave_core_job_max_archiving_tasks**
     - int
     - | The maximum number of job archiving
       | tasks to run concurrently.
       | Default: 5
   * - **agave_core_job_max_monitoring_tasks**
     - int
     - | The maximum number of job monitoring
       | tasks to run concurrently.
       | Default: 2
   * - **agave_core_job_max_submission_tasks**
     - int
     - | The maximum number of job submission
       | tasks to run concurrently.
       | Default: 1



   * - **agave_core_files_mem_limit**
     - string
     - | Max memory for the files container. This
       | should be at least 8GB for a worker. API
       | only deployment can be significantly
       | less. This value Will bound xmx on the
       | JVM was well. General rule of thumb is
       | 0.5 core and 1GB memory per data-centric
       | task per container. High job rates can
       | grow JVM system utilization upwards of
       | 1CPU and 2GB memory per transfer task,
       | so plan accordingly.
       |
       | If your resources allow, set
       | agave_core_files_mem_limit to False
       | to uncap the memory on this container.
       | Default: 8192m
   * - **core_deploy_files**
     - bool
     - | Should the Files container be deployed.
       | Default: true
   * - **agave_core_files_max_staging_tasks**
     - int
     - | The maximum number of file transfer
       | tasks to run concurrently.
       | Default: 5
   * - **agave_core_files_max_transform_tasks**
     - int
     - | The maximum number of file transform
       | tasks to run concurrently.
       | Default: 5


   * - **agave_core_systems_mem_limit**
     - string
     - | Max memory for systems container. 2GB
       | should be enough under normal usage.
       | Default: 2048m
   * - **core_deploy_systems**
     - bool
     - | Should the Systems container be deployed.
       | Default: true


   * - **agave_core_apps_mem_limit**
     - string
     - | Max memory for apps container. 2GB
       | should be enough under normal usage. For
       | single host deployments and worker
       | containers, this can be bumped up to 4GB
       | based on the number of publishing and
       | cloning tasks.
       | Default: 4096m
   * - **core_deploy_apps**
     - bool
     - | Should the Apps container be deployed.
       | Default: true
   * - **agave_core_apps_max_publishing_tasks**
     - int
     - | The maximum number of app publishing
       | tasks to run concurrently.
       | Default: 1
   * - **agave_core_apps_max_cloning_tasks**
     - int
     - | The maximum number of apps cloning tasks
       | to run concurrently.
       | Default: 1


   * - **agave_core_monitors_mem_limit**
     - string
     - | Max memory for monitors container. 2GB
       | should be enough under normal usage. For
       | single host deployments and worker
       | containers, this can be bumped up to 8GB
       | based on the number of monitoring tasks
       | and frequency with which they run.
       | Default: 4096m
   * - **core_deploy_monitors**
     - bool
     - | Should the Monitors container be deployed.
       | Default: true
   * - **agave_core_monitor_min_check_interval**
     - int
     - | The minimum time between checks that users
       | can configure.
       | Default: 0
   * - **agave_core_monitors_max_tasks**
     - int
     - | The maximum number of monitoring tasks to
       | run concurrently.
       | Default: 1
   * - **agave_core_monitors_max_retries**
     - int
     - | The maximum number of retires attempts
       | the service will make when performing a
       | synchronous monitoring check initiated
       | by the user.
       | Default: 3



   * - **agave_core_profiles_mem_limit**
     - string
     - | Max memory for custom profiles container.
       | 2GB should be enough under normal usage. Add
       | containers if you run out of memory.
       | Default: 1024m
   * - **core_deploy_custom_profiles**
     - bool
     - | Should the Profiles container be deployed.
       | Default: false


   * - **agave_core_tags_mem_limit**
     - string
     - | Max memory for tags API container.
       | 2GB should be enough under normal usage. Add
       | containers if you run out of memory.
       | Default: 2048m
   * - **core_deploy_tags**
     - bool
     - | Should the Tags container be deployed.
       | Default: false


   * - **agave_core_uuids_mem_limit**
     - string
     - | Max memory for uuids API container.
       | 2GB should be enough under normal usage. Add
       | containers if you run out of memory.
       | Default: 2048m
   * - **core_deploy_uuids**
     - bool
     - | Should the uuids container be deployed.
       | Default: false


   * - **agave_core_postits_mem_limit**
     - string
     - | Max memory for posttis API container.
       | 2GB should be enough under normal usage. Add
       | containers if you run out of memory.
       | Default: 2048m
   * - **core_deploy_posttis**
     - bool
     - | Should the posttis container be deployed.
       | Default: false


   * - **agave_core_usage_mem_limit**
     - string
     - | Max memory for usage API container.
       | 2GB should be enough under normal usage. Add
       | containers if you run out of memory.
       | Default: 1024m
   * - **core_deploy_usage**
     - bool
     - | Should the usage container be deployed.
       | Default: false


   * - **agave_core_tenants_mem_limit**
     - string
     - | Max memory for tenants API container.
       | 2GB should be enough under normal usage. Add
       | containers if you run out of memory.
       | Default: 1024m
   * - **core_deploy_tenants**
     - bool
     - | Should the tenants container be deployed.
       | Default: false



   * - **agave_core_logging_mem_limit**
     - string
     - | Max memory for the logging container. PHP
       | services rarely need more than 2GB.
       | Default: 1024m
   * - **core_deploy_logging**
     - bool
     - | Should the logging API be deployed.
       | Default: true

   * - **agave_core_docs_mem_limit**
     - string
     - | Max memory for the documentation container.
       | This should almost never need more than 512m
       | Default: 512m
   * - **core_deploy_docs**
     - bool
     - | Should the API documentation be deployed.
       | Default: false


   * - **agave_core_metadata_mem_limit**
     - string
     - | Max memory for metadata container. 4GB
       | should be enough under normal usage. If
       | request size is particularly large, bump
       | the memory by a couple gig. Anything over
       | 4GB, and you should scale out the
       | containers rather than bumping this one
       | in size.
       | Default: 4096m
   * - **core_deploy_metadata**
     - bool
     - | Should the metadata API be deployed.
       | Default: true
   * - **agave_core_metadata_db_host**
     - string
     - | Mongo host for core services.
       | Default: same as mongodb_host
   * - **agave_core_metadata_db_port**
     - string
     - | Mongo port for core services.
       | Default: same as mongodb_port
   * - **agave_core_metadata_db_user**
     - string
     - | Mongo user for core services.
       | Default: same as mongodb_user


   * - **agave_core_notifications_mem_limit**
     - string
     - | Max memory for notifications container. 2GB
       | should be enough under normal usage. Split
       | out a worker container and bump threads
       | before bumping memory above 4GB. The load
       | here comes from event processing, not the
       | API.
       | Default: 2048m
   * - **core_deploy_notifications**
     - bool
     - | Should the Notifications container be deployed.
       | Default: true
   * - **agave_core_notifications_max_notification_tasks**
     - int
     - | The number of notification processing
       | workers to start up.
       | Default: 2
   * - **agave_core_notification_queue**
     - string
     - | Beanstalk queue for core services. (e.g.
       | "staging.notifications.queue")
   * - **agave_core_notification_topic**
     - string
     - | Beanstalk topic for core services. (e.g.
       | "staging.notifications.topic")
   * - **agave_core_notification_failed_db_host**
     - string
     - | Hostname of the mongodb to store failed
       | notification messages in.
       | Default: same as mongodb_host
   * - **agave_core_notification_failed_db_port**
     - string
     - | Port of the mongodb to store failed
       | notification messages in.
       | Default: same as mongodb_port
   * - **agave_core_notification_failed_db_user**
     - string
     - | Username of the mongodb to store failed
       | notification messages in.
       | Default: same as mongodb_user
   * - **agave_core_notification_failed_db_password**
     - string
     - | Password of the mongodb to store failed
       | notification messages in.
       | Default: same as mongodb_password
   * - **agave_core_notification_failed_db_scheme**
     - string
     - | Database scheme of the mongodb to store
       | failed notification messages in.
       | Default: notifications


   * - **agave_core_realtime_mem_limit**
     - string
     - | Max memory for realtime container. 2GB
       | should be enough under normal usage.
       | Default: 2048m
   * - **core_deploy_realtime**
     - bool
     - | Should the Realtime container be deployed.
       | Default: false
   * - **agave_core_realtime_provider**
     - string
     - | Type of backend service to use for realtime API.
       | Currently value "fanout", "pushpin", and "none"
       | are supported.
       | Default: none
   * - **agave_core_realtime_service**
     - string
     - | Addressable location of the backend streaming
       | server for realtime API.
       | Default:
   * - **agave_core_realtime_service_realm_id**
     - string
     - | Realm id when using the fanout backend.
       | Default:
   * - **agave_core_realtime_service_realm_key**
     - string
     - | Realm key when using the fanout backend.
       | Default:


   * - **core_deploy_stats**
     - bool
     - | Whether to deploy the stats container.
       | *Note: This container is currently optimized*
       | *for Agave's production environment and*
       | *requires a Pingdom account, among other*
       | *configurations.*

