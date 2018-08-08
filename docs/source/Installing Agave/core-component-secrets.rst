Core Components
---------------
Here we list the required configuration fields for the ``agave_core_config/<tenant_id>_passwords`` file and a description of their use. This file will always be imported after the  ``agave_core_config/<tenant_id>.yml`` file, thus these values will take precedence.

.. list-table:: Default Core component password variables
   :widths: 30 15 55
   :header-rows: 1

   * - Variable
     - Type
     - Description
   * - **mysql_core_user**
     - string
     - | Username for the core MySQL connection.
       | Default: agaveapi
   * - **mysql_core_password**
     - string
     - | Password for the core MySQL connection.
       | Default: p@ssword
   * - **mysql_core_root_password**
     - string
     - | Username for the core MySQL connection.
       | Default: changeme


   * - **agave_core_smtps_user**
     - string
     - | Username for the SMTP server.
       | Default: agaveapi
   * - **agave_core_smtps_password**
     - string
     - | Password for the SMTP server.
       | Default: changeme


   * - **agave_core_notification_failed_db_user**
     - string
     - | Username for the failed notification
       | user account in the MongoDB server.
       | Default: mongodb_user
   * - **agave_core_notification_failed_db_password**
     - string
       | Password for the failed notification
       | user account in the MongoDB server.
       | Default: mongodb_password


   * - **agave_core_realtime_service_realm_id**
     - string
     - | ID of the fanout.io cloud realm to which
       | realtime notifications will be published
       | when agave_core_realtime_provider =
       | pushpin in the core config settings.
       | Default:
   * - **agave_core_realtime_service_realm_key**
     - string
     - | Private key of the fanout.io cloud realm
       | to which realtime notifications will be
       | published when
       | agave_core_realtime_provider = pushpin
       | in the core config settings.
       | Default:


   * - **agave_core_metadata_user**
     - string
     - | Username for the MongoDB server.
       | Default: mongodb_user
   * - **agave_core_metadata_password**
     - string
       | Password for the MongoDB server
       | Default: mongodb_password


   * - **agave_core_messaging_user**
     - string
     - | Username for the messaging service.
       | Leave blank for beanstalk and other
       | services that do not support auth.
       | Default: messaging_user
   * - **agave_core_messaging_password**
     - string
       | Password for the messaging service.
       | Leave blank for beanstalk and other
       | services that do not support auth.
       | Default: messaging_password

