DB Components
---------------
Here we list the required database component configuration fields to be included in the ``agave_core_config/<tenant_id>_passwords`` file and a description of their use.

.. list-table:: Default DB component password variables
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


   * - **mongodb_user**
     - string
     - | Username for the MongoDB server.
       | Default: wcs
   * - **mongodb_password**
     - string
       | Password for the MongoDB server
       | Default: changeme


   * - **messaging_user**
     - string
     - | Username for the messaging service.
       | Leave blank for beanstalk and other
       | services that do not support auth.
   * - **messaging_password**
     - string
       | Password for the messaging service.
       | Leave blank for beanstalk and other
       | services that do not support auth.


