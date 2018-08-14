Core Components
---------------
The following tables describe variables for use with the Ansible installer that can be used to configure the Core components:

.. list-table:: Core component Playbook variables
   :widths: 30 15 55
   :header-rows: 1

   * - Variable
     - Type
     - Description
   * - **mysql_core_host**
     - string
     - | Host or ip of the core services MySQL database.
       | Default: db host ip address
   * - **mysql_core_port**
     - string
     - | Port of the core services MySQL database.
       | Default: 3301


   * - **messaging_provider**
     - string
     - | Which messaging service to deploy
       | Default: beanstalk
   * - **messaging_host**
     - string
     - | Host for Beanstalk server.
       | Default: db host ip address
   * - **messaging_port**
     - string
     - | Port for Beanstalk server.
       | Default: 11300


   * - **mongodb_host**
     - string
     - | Mongo host for core services.
       | Default: db host ip address
   * - **mongodb_port**
     - string
     - | Mongo port for core services.
       | Default: 27107


   * - **core_deploy_maildev**
     - string
     - | SMTP target for the maildev relay. (Use
       | "smtp.sendgrid.net" if sendgrid provider is
       | configured.)
       | Default: smtp.sendgrid.net

   * - **agave_core_smtps_host**
     - string
     - | SMTP target for the maildev relay. (Use
       | "smtp.sendgrid.net" if sendgrid provider is
       | configured.)
       | Default: smtp.sendgrid.net
   * - **agave_core_smtps_port**
     - string
     - | SMTP target host for the maildev server.
       | Default: 587
   * - **agave_core_smtps_auth**
     - bool
     - | Whether auth is required for the SMTP
       | target host. This will also determine
       | whether auth is needed by the maildev
       | relay.
       | Default: true
   * - **agave_core_smtps_from_name**
     - string
     - | From name used in email communications.
       | Default: Agave Notifications
   * - **agave_core_smtps_from_address**
     - string
     - | From address used in email communications.
       | Default: no-reply@agaveplatform.org