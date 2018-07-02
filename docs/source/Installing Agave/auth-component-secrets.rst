Auth Components
---------------
Here we list the required configuration fields for the ``tenants/<tenant_id>/<tenant_id>_passwords`` file and a description of their use.

.. list-table:: Default Auth component password variables
   :widths: 30 15 55
   :header-rows: 1

   * - Variable
     - Type
     - Description
   * - **auth_ldap_bind_password**
     - string
     - | The password used to bing to the hosted LDAP.
       | Should be configured when **use_hosted_id** is
       | True.
   * - **remote_auth_ldap_bind_password**
     - string
     - | The password used to bind to the remote LDAP.
       | Should be configured when **use_remote_userstore**
       | is True.
   * - **apim_admin_pass**
     - string
     - | The password for the APIM admin account.
       |
       | *Note: this must first be reset using the APIM*
       | *password reset form within the carbon admin*
       | *application. Changing this setting prior to*
       | *updating the password via the web form will*
       | *break the APIM.*
   * - **mysql_tenant_user**
     - string
     - | The username that APIM should use to authenticate
       | to MySQL.
   * - **mysql_tenant_pass**
     - string
     - | The password that APIM should use to authenticate
       | to MySQL.
