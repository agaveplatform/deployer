***********************
Example Inventory Files
***********************

After getting to know the basics of configuring your own inventory file, you can review the following example inventories which describe various environment topographies, including using multiple core hosts for higher capacity. You can choose an example that matches your requirements, modify it to match your own environment, and use it as your inventory file when running the installation.

Sandbox Installations
======================

You can configure an environment with single Auth, Persistence, and either single or multiple Core hosts.


Single Auth, Single Core, and Single Persistence
------------------------------------------------
The following table describes an example environment for a single Auth, single Core, and single Persistence host:

.. list-table:: Simple 3 host setup with each logical component group deployed on a dedicated host.
   :widths: 20 30
   :header-rows: 1

   * - Host Name
     - Infrastructure Component to Install
   * - auth.example.com
     - | All Auth components
   * - core.example.com
     - | All Core components
   * - db.example.com
     - | All Persistence components

You can see these example hosts present in the ``[auth]``, ``[core]``, and ``[db]`` sections of the following example inventory file:

::
    # General settings to apply to all playbooks.
    [all:vars]

    # the name of your tenant.
    tenant_id=sandbox

    # The name of the core service config file to read in.
    core_config_file=sandbox

    # Create a docker_hosts group that contains the auth, core, and db groups
    [docker_hosts:vars]

    # SSH user, this user should allow ssh based auth without requiring a password
    ansible_ssh_user=root

    # If ansible_ssh_user is not root, ansible_become must be set to true
    #ansible_become=true


    [docker_hosts:children]
    db
    auth
    core

    [db]
    db.example.com ansible_ssh_host=192.168.205.12

    [auth]
    auth.example.com ansible_ssh_host=192.168.205.10

    [core]
    core.example.com ansible_ssh_host=192.168.205.11


To use this example, modify the file to match your environment and specifications, and save it as /etc/ansible/hosts.


Single Auth, Multiple Core, and Single Persistence
------------------------------------------------
The following table describes an example environment for a single Auth, single Core, and single Persistence host:

.. list-table:: Simple 3 host setup with each logical component group deployed on a dedicated host.
   :widths: 20 30
   :header-rows: 1

   * - Host Name
     - Infrastructure Component to Install
   * - auth.example.com
     - | All Auth components
   * - api.core.example.com
     - | All Core frontend components
   * - worker.core.example.com
     - | All Core backend worker components
   * - db.example.com
     - | All Persistence components

You can see these example hosts present in the ``[auth]``, ``[core]``, and ``[db]`` sections of the following example inventory file:

::
    # General settings to apply to all playbooks.
    [all:vars]

    # the name of your tenant.
    tenant_id=sandbox

    # The name of the core service config file to read in.
    core_config_file=sandbox

    # Create a docker_hosts group that contains the auth, core, and db groups
    [docker_hosts:vars]

    # SSH user, this user should allow ssh based auth without requiring a password
    ansible_ssh_user=root

    # If ansible_ssh_user is not root, ansible_become must be set to true
    #ansible_become=true


    [docker_hosts:children]
    db
    auth
    core

    [db]
    db.example.com ansible_ssh_host=192.168.205.12

    [auth]
    auth.example.com ansible_ssh_host=192.168.205.10

    [core]

    [core:children]
    core_api
    core_workers

    [core_api]
    api.core.example.com ansible_ssh_host=192.168.205.11  agave_core_api_only=True

    [core_workers]
    worker.core.example.com ansible_ssh_host=192.168.205.13  agave_core_workers_only=True


To use this example, modify the file to match your environment and specifications, and save it as /etc/ansible/hosts.



Custom Installations
===================

Single Auth, Multiple Core, and Hosted Persistence
--------------------------------------------------------
The following table describes an example environment for a single Auth and multiple Core hosts supporting workers for specific power users. Persistence is delgated to cloud hosted services.

.. list-table:: Custom 4 host setup with cloud hosted persistence.
   :widths: 20 30
   :header-rows: 1

   * - Host Name
     - Infrastructure Component to Install
   * - auth.example.com
     - | All Auth components
   * - api.core.example.com
     - | All Core frontend components
   * - jdoe.worker.core.example.com
     - | All Core backend worker components
   * - jobs.worker.core.example.com
     - | All Core backend worker components
   * - data.worker.core.example.com
     - | All Persistence components

You can see these example hosts present in the ``[auth]``, ``[core_api]``, and ``[core_workers]`` sections of the following example inventory file:

::
    # General settings to apply to all playbooks.
    [all:vars]

    # the name of your tenant.
    tenant_id=sandbox

    # The name of the core service config file to read in.
    core_config_file=sandbox

    # Create a docker_hosts group that contains the auth, core, and db groups
    [docker_hosts:vars]

    # SSH user, this user should allow ssh based auth without requiring a password
    ansible_ssh_user=root

    # If ansible_ssh_user is not root, ansible_become must be set to true
    #ansible_become=true

    # hosted core mariadb cluster
    mysql_core_host: mariadb.12345.us-east-1.rds.amazonaws.com
    mysql_core_port: 3306
    mysql_core_user: agaveapi

    # hosted mongodb
    agave_core_metadata_host=atlas.us-east-1.compute.amazonaws.com
    agave_core_metadata_port=27017
    agave_core_metadata_user=iam_user_1

    # auth message queue
    agave_core_messaging_host: mq-aws-eu-west-1-1.iron.io
    agave_core_messaging_port: 11300
    agave_core_messaging_user: iron_user_1

    # hosted streaming and push service
    agave_core_realtime_provider=fanout
    agave_core_realtime_host=12345.fanout.io

    # hosted auth mariadb cluster
    mysql_host: mariadb.12345.us-east-1.rds.amazonaws.com
    mysql_port: 3306
    mysql_core_user: agaveapimuser

    # auth message queue
    beanstalk_port: 11300
    beanstalk_tube: mq-aws-eu-west-1-1.iron.io

    [docker_hosts:children]
    db
    auth
    core

    [db]

    [auth]
    auth.example.com ansible_ssh_host=192.168.205.10

    [core]

    [core:children]
    core_api
    core_workers

    [core_api]
    api.core.example.com ansible_ssh_host=192.168.205.11  agave_core_api_only=True

    [core_workers]
    # Tells the installer to only deploy the data worker container(s) on this
    # host and to limit them to tasks for anyone but user jdoe.
    # - The memory limit has been lifted on this container, so it can use the
    #   entire host memory.
    # - The number of concurrent data movement tasks is bumped to 10.
    # - The number of concurrent data transformation tasks is bumped to 10.
    # - Relay transfers are enabled, so any file under 1GB in size will be moved
    #   via sequential GET and PUT operations rather than streamed through memory
    #   buffers like larger files.
    data.worker.core.example.com ansible_ssh_host=192.168.205.13  agave_core_workers_only=True core_deploy_jobs=False agave_core_dedicated_user_ids=!jdoe agave_core_files_mem_limit=False agave_core_files_max_staging_tasks=10 agave_core_files_max_transform_tasks=10 agave_core_allow_relay_transfer=True agave_core_max_relay_transfer_size=1

    # Tells the installer to only deploy the jobs worker container(s) on this
    # host and to limit them to tasks for anyone but user jdoe.
    # - The memory limit has been lifted on this container, so it can use the
    #   entire host memory.
    # - The number of concurrent job submission tasks is bumped to 5.
    # - The number of concurrent job staging tasks is bumped to 15.
    # - The number of concurrent job archiving tasks tasks is bumped to 15.
    # - The number of concurrent job monitoring tasks tasks is bumped to 2.
    # - Relay transfers are explicitly disabled.
    jobs.worker.core.example.com ansible_ssh_host=192.168.205.14  agave_core_workers_only=True core_deploy_files=False agave_core_dedicated_user_ids=!jdoe agave_core_jobs_mem_limit=False agave_core_job_max_submission_task=5 agave_core_job_max_staging_tasks=15 agave_core_job_max_archiving_tasks=15 agave_core_job_max_monitoring_tasks=2 agave_core_allow_relay_transfer=False

    # Tells the installer to deploy all the worker container(s) on this host and
    # limit them to only process tasks for user jdoe.
    # - The memory limit has been lifted on this container, so it can use the
    #   entire host memory.
    # - The number of concurrent job submission tasks is bumped to 7.
    # - The number of concurrent job staging tasks is bumped to 7.
    # - The number of concurrent job archiving tasks tasks is bumped to 7.
    # - The number of concurrent job monitoring tasks tasks is bumped to 2.
    # - The number of concurrent data movement tasks is bumped to 10.
    # - The number of concurrent data transformation tasks is bumped to 10.
    # - Relay transfers are explicitly disabled.
    jdoe.worker.core.example.com ansible_ssh_host=192.168.205.15  agave_core_workers_only=True agave_core_dedicated_user_ids=jdoe agave_core_jobs_mem_limit=16384 agave_core_files_mem_limit=16384 agave_core_job_max_submission_task=7 agave_core_job_max_staging_tasks=7 agave_core_job_max_archiving_tasks=7 agave_core_job_max_submission_task=5 agave_core_job_max_staging_tasks=15 agave_core_job_max_monitoring_tasks=2 agave_core_files_max_staging_tasks=10 agave_core_files_max_transform_tasks=10 agave_core_allow_relay_transfer=False


To use this example, modify the file to match your environment and specifications, and save it as /etc/ansible/hosts.
