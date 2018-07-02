Core Components
---------------
Here we list the required configuration fields for the ``agave_core_config/<tenant_id>_passwords`` file and a description of their use.

.. list-table:: Default Core component password variables
   :widths: 30 15 55
   :header-rows: 1

   * - Variable
     - Type
     - Description
   * - **mysql_core_password**
     - string
     - | Password for the core MySQL connection.
   * - **agave_core_smtps_password**
     - string
     - | Password for the SMTP server.
   * - **agave_core_metadata_db_password**
     - string
     - | Password for the Mongo db server.

