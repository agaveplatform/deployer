***********************
Example Inventory Files
***********************

After getting to know the basics of configuring your own inventory file, you can review the following example inventories which describe various environment topographies, including using multiple core hosts for higher capacity. You can choose an example that matches your requirements, modify it to match your own environment, and use it as your inventory file when running the installation.

Sandbox Installations
======================

You can configure a sandbox environment with 1 or more hosts.


Single Host
------------
The following table describes an example environment for a single host deployment:

.. list-table:: Simple 1 host setup with each logical component group deployed on the same dedicated host.
   :widths: 20 30
   :header-rows: 1

   * - Host Name
     - Infrastructure Component to Install
   * - sandbox.example.com
     - | All Auth, Core, and Persistence components

You can see the same host present in the ``[auth]``, ``[core]``, and ``[db]`` sections of the following example inventory file.

::

    [all]
    sandbox.example.com ansible_ssh_host=192.168.205.5

		# General settings to apply to all playbooks.
    [all:vars]

    # the name of your tenant.
    tenant_id=sandbox
    agave_tenant_id=sandbox

    # the public hostname or ip of your installation
    tenant_public_domain_or_ip=sandbox.agaveplatform.org

    # The name of the core service config file to read in.
    core_config_file=sandbox

    # Create a agave group that contains the auth, core, and db groups
    [agave:vars]

    # SSH user, this user should allow ssh based auth without requiring a password
    ansible_ssh_user=root

    [agave:children]
    db
    auth
    core

    [db]
    sandbox.example.com

    [auth]
    sandbox.example.com

    [core]
    # This group will host the science apis and should have at least 4 cores, 16GB memory, and 80GB disk. The following
    # configuration caps the memory on individual core api containers and limits the number of workers tasks per
    # container to relatively modest counts. This is not a production configuration. You should seriously consider
    # splitting the worker and core services out over multiple hosts, or provisioning a server with at least 16 cores
    # and 64GB memory for any significant traffic or data movement.
    sandbox.example.com agave_core_tenants_mem_limit=128m agave_core_logging_mem_limit=256m agave_core_docs_mem_limit=128m agave_core_uuids_mem_limit=1024m agave_core_tags_mem_limit=1024m core_deploy_realtime=False agave_core_realtime_mem_limit=512m agave_core_metadata_mem_limit=1024m agave_core_monitors_mem_limit=1024m agave_core_systems_mem_limit=1024m agave_core_apps_mem_limit=1024m agave_core_notifications_mem_limit=1024m agave_core_job_max_submission_task=1 agave_core_job_max_staging_tasks=3 agave_core_job_max_archiving_tasks=2 agave_core_job_max_monitoring_tasks=1 agave_core_files_max_staging_tasks=2 agave_core_files_max_transform_tasks=1 core_deploy_monitors=False core_deploy_notifications=False core_deploy_transforms=False agave_core_jobs_mem_limit=4096m agave_core_files_mem_limit=4096m


To use this example, modify the file to match your environment and specifications, and save it as /etc/ansible/hosts. When deploying all components to the same host, the core components proxy need to be run on an alternate port to avoid conflict. These can be set in the two `sandbox.yml` variable files or as extra vars when invoking the playbook.

::

  ansible-playbook deploy_agave.plbk \
      --become \
      -i host_vars/vagrant_single_host
      -e core_api_port=8080 \
      -e agave_core_proxy_http_port=8080 \
      -e agave_core_proxy_https_port=8443 \
      -e agave_core_iplant_proxy_service=http://149.165.157.217:8080


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
    agave_tenant_id=sandbox

    # the public hostname or ip of your installation
    tenant_public_domain_or_ip=sandbox.agaveplatform.org

    # The name of the core service config file to read in.
    core_config_file=sandbox

    # Create a agave group that contains the auth, core, and db groups
    [agave:vars]

    # SSH user, this user should allow ssh based auth without requiring a password
    ansible_ssh_user=root

    # If ansible_ssh_user is not root, ansible_become must be set to true
    #ansible_become=true


    [agave:children]
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
--------------------------------------------------
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
    agave_tenant_id=sandbox

    # the public hostname or ip of your installation
    tenant_public_domain_or_ip=sandbox.agaveplatform.org

    # The name of the core service config file to read in.
    core_config_file=sandbox

    # Create a agave group that contains the auth, core, and db groups
    [agave:vars]

    # SSH user, this user should allow ssh based auth without requiring a password
    ansible_ssh_user=root

    # If ansible_ssh_user is not root, ansible_become must be set to true
    #ansible_become=true


    [agave:children]
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
    worker.core.example.com ansible_ssh_host=192.168.205.13  agave_core_workers_only=True core_deploy_monitors=False core_deploy_notifications=False core_deploy_transforms=False


To use this example, modify the file to match your environment and specifications, and save it as /etc/ansible/hosts.



Custom Installations
====================

Single Auth, Multiple Core, and Cloud Hosted Persistence
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

You can see these example hosts present in the ``[auth]``, ``[core_api]``, and ``[core_workers]`` sections of the following example inventory file. Note that we have switched from the traditional INI syntax to YAML to make adding multiple host variables more legible.

::

  # General settings to apply to all playbooks.
  all:
    vars:
      # the name of your tenant.
      tenant_id: sandbox
      agave_tenant_id: sandbox

      # the public hostname or ip of your installation
      tenant_public_domain_or_ip: sandbox.agaveplatform.org

      # The name of the core service config file to read in.
      core_config_file: sandbox
    children:
      # Create a agave group that contains the auth, core, and db groups
      agave:
        # common variables to all component hosts
        vars:
          # SSH user, this user should allow ssh based auth without requiring a password
          ansible_ssh_user: root

          # mariadb cluster host
          mysql_core_host: mariadb.12345.us-east-1.rds.amazonaws.com
          # mariadb cluster port
          mysql_core_port: 3306
          # mariadb cluster username
          mysql_core_user: agaveapi

          # mongodb core cluster host
          agave_core_metadata_host: atlas.us-east-1.compute.amazonaws.com
          # mongodb core cluster port
          agave_core_metadata_port: 27017
          # mongodb core cluster username
          agave_core_metadata_user: iam_user_1

          # set message queue provider type is ironmq's beanstalk interface
          agave_core_messaging_provider: ironbeanstalk
          # ironmq queue
          agave_core_messaging_host: mq-aws-eu-west-1-1.iron.io
          # ironmq port
          agave_core_messaging_port: 11300
          # ironmq user
          agave_core_messaging_user: iron_user_1

          # hosted streaming and push service
          agave_core_realtime_provider: fanout
          agave_core_realtime_host: 12345.fanout.io

          # mariadb auth cluster host
          mysql_host: mariadb.12345.us-east-1.rds.amazonaws.com
          # mariadb auth cluster port
          mysql_port: 3306
          # mariadb auth cluster username
          mysql_core_user: agaveapi

          # ironmq queue
          beanstalk_host: mq-aws-eu-west-1-1.iron.io
          # ironmq port
          beanstalk_port: 11300
          # ironmq user
          beanstalk_user: iron_user_1

        children:
          # db group is empty because all the persistence components are cloud services.
          db:

          # auth component group. evertyhing is going on a single component
          auth:
            hosts:
              auth.example.com:
                ansible_ssh_host: 192.168.205.10

          # core component group split acoss multiple worker hosts and asingle API host
          core:
            children:
              # Group for all core science api frontend services
              core_api:
                hosts:
                  api.core.example.com:
                    ansible_ssh_host: 192.168.205.11
                    # Do not deploy any workers on this host and ensure no worker threads
                    # are running in the api containers
                    agave_core_api_only: True

              # Group for all core science api backend workers
              core_workers:
                vars:
                  # only enable science api backend workers on hosts in this group
                  agave_core_workers_only: True

                hosts:
                  # This host will only have the science api backend data workers
                  # deployed on it. As the only component on the host, it will have
                  # full run of the host's memory, disk, and cpu share.
                  data.worker.core.example.com:
                    ansible_ssh_host: 192.168.205.13
                    # Do not deploy the monitor worker containers on this host
                    core_deploy_monitors: False 
                    # Do not deploy the notificaiton  worker containers on this host
                    core_deploy_notifications: False
                    # Do not deploy the transform worker containers on this host
                    core_deploy_transforms: False
                    # Do not deploy the job worker containers on this host
                    core_deploy_jobs: False
                    # Tell the workers to accept tasks for anyone but user jdoe.
                    agave_core_dedicated_user_ids: !jdoe
                    # Don't cap the container memory. Let 'er rip
                    agave_core_files_mem_limit: False
                    # The number of concurrent data movement tasks is bumped to 10.
                    agave_core_files_max_staging_tasks: 10
                    # The number of concurrent data transformation tasks is bumped to 10.
                    agave_core_files_max_transform_tasks: 10
                    # Enable relay transfers
                    agave_core_allow_relay_transfer: True
                    # Cap relayed file size at 1GB. This means any file under 1GB in size
                    # will be moved via sequential GET and PUT operations rather than
                    # streamed through memory buffers like larger files.
                    agave_core_max_relay_transfer_size: 1

                  # This host will only have the science api backend job workers
                  # deployed on it. As the only component on the host, it will have
                  # full run of the host's memory, disk, and cpu share.
                  jobs.worker.core.example.com:
                    ansible_ssh_host: 192.168.205.14
                    # Do not deploy the monitor worker containers on this host
                    core_deploy_monitors: False
                    # Do not deploy the notificaiton  worker containers on this host
                    core_deploy_notifications: False
                    # Do not deploy the transform worker containers on this host
                    core_deploy_transforms: False
                    # Do not deploy the data worker containers on this host
                    core_deploy_files: False
                    # Tell the workers to accept tasks for anyone but user jdoe.
                    agave_core_dedicated_user_ids: !jdoe
                    agave_core_jobs_mem_limit: False
                    # The number of concurrent job submission tasks is bumped to 5.
                    agave_core_job_max_submission_task: 5
                    # The number of concurrent job staging tasks is bumped to 15.
                    agave_core_job_max_staging_tasks: 15
                    # The number of concurrent job archiving tasks tasks is bumped to 15.
                    agave_core_job_max_archiving_tasks: 15
                    # The number of concurrent job monitoring tasks tasks is bumped to 2.
                    agave_core_job_max_monitoring_tasks: 2
                    # Explicitly disable relay transfers
                    agave_core_allow_relay_transfer: False

                  # This host will be dedicated to processing tasks for a single user.
                  # All backend worker components will be deployed, but they will
                  # only accept tasks for user jdoe. The number of concurrent job tasks
                  # is adjusted to handle a higher degree of job throughput and small to
                  # moderate data movement. The memory constraint on each container reflects
                  # these settings.
                  jdoe.worker.core.example.com:
                    ansible_ssh_host: 192.168.205.15
                    # Do not deploy the monitor worker containers on this host
                    core_deploy_monitors: False
                    # Do not deploy the notificaiton  worker containers on this host
                    core_deploy_notifications: False
                    # Do not deploy the transform worker containers on this host
                    core_deploy_transforms: False
                    # Only process tasks for user jdoe
                    agave_core_dedicated_user_ids: jdoe
                    # Cap job container memory at 16GB. Notice the "g"
                    agave_core_jobs_mem_limit: "16g"
                    # Cap job container memory at 16GB. Notice the "g"
                    agave_core_files_mem_limit: "16g"
                    # The number of concurrent job submission tasks is bumped to 4.
                    agave_core_job_max_submission_task: 4
                    # The number of concurrent job staging tasks is bumped to 4.
                    agave_core_job_max_staging_tasks: 4
                    # The number of concurrent job archiving tasks tasks is bumped to 4.
                    agave_core_job_max_archiving_tasks: 4
                    # The number of concurrent job monitoring tasks tasks is bumped to 2.
                    agave_core_job_max_monitoring_tasks: 2
                    # The number of concurrent data movement tasks is bumped to 6.
                    agave_core_files_max_staging_tasks: 6
                    # The number of concurrent data transformation tasks is bumped to 6.
                    agave_core_files_max_transform_tasks: 6
                    # Explicitly disable relay transfers
                    agave_core_allow_relay_transfer: False

To use this example, modify the file to match your environment and specifications, and save it as /etc/ansible/hosts.
