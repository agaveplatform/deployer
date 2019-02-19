Auth Components
---------------
Agave is a multi-tenant platform, and each tenant deploys a dedicated auth component while the other components (core and persistence) are shared across tenants. The Ansible installer can support the installation and management of multiple tenants. Each tenant is identified by the value of ``tenant_id`` provided in the inventory file. The default values for the tenant_id is "sandbox".

The following tables describe variables for use with the Ansible installer that can be used to customize the Auth components:

.. list-table:: Auth component Playbook variables
   :widths: 30 15 55
   :header-rows: 1

   * - Variable
     - Type
     - Description
   * - **tenant_id**
     - string
     - | A unique id for this tenant.
       | *Note: This will be replaced by the ``agave_tenant_id``*
       | *field in the near future. Both are currently*
       | *required.*
   * - **agave_tenant_id**
     - string
     - | A unique id for this tenant.
       | *Note: This will be replace the ``tenant_id``*
       | *field in the near future. Both are currently*
       | *required.*
   * - **tenant_public_domain_or_ip**
     - string
     - | The public domain name or ip address of the
       | auth server. This is the address you will use
       | to connect to your installation.
       | *required.*
   * - **agave_env**
     - string
     - | (staging/prod). The Agave environment used for
       | this tenant. Determines the core services that
       | will be invoked. Note that the IP address for the
       | core services can be resolved by docker compose
       | using the extra_hosts stanza for platform
       | deployments that are not in DNS.
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
   * - **tenant_admin_role**
     - string
     - | The name of the tenant admine role.
   * - **agave_profiles_url**
     - string
     - | URL for the profiles service. When the tenant uses
       | the Agave hosted identity, this URL should be of
       | the form
       | ``profiles.<tenant_id>.agave.tacc.utexas.edu/profiles``
       | and will be resolved automatically; however, for
       | other tenants such as Cyverse, this URL will be
       | different.
   * - **haproxy_auth_version**
     - string
     - | Version of the HA Proxy auth service to use
       | (Defaults to latest).
   * - **apim_httpd_version**
     - string
     - | Version of the auth httpd service to use
       | (Ddefaults to latest).
   * - **apim19_base_version**
     - string
     - | Version of APIM 1.9 auth service to use
       | (Defaults to latest).
   * - **agave_id_dedicated_version**
     - string
     - | Version of the Agave ID auth service to use
       | (Defaults to latest).
   * - **agave_clients_dedicated_version**
     - string
     - | Version of the Agave clients auth service to use
       | (Defaults to latest).
   * - **admin_services_nginx_version**
     - string
     - | Version of the admin nginx auth service to use
       | (Defaults to latest).
   * - **flask_admin_services_version**
     - string
     - | Version of the admin auth service to use
       | (Defaults to latest).
   * - **update_auth_dns**
     - bool
     - | Whether or not to update the ``/etc/hosts`` file
       | with the location of the auth mysql server for the
       | auth containers. Use this when the host name/domain
       | for the mysql server is not in DNS.
   * - **core_api_protocol**
     - string
     - | (http or https). Protocol the auth services will
       | use when communicating with the core services. Use
       | ``http`` unless the auth services must communicate
       | with the core services across a firewall.
   * - **core_api_port**
     - int
     - | Port on which the auth services will connect to
       | core services proxy. Defaults to 443 or 80 depending
       | on the value of **core_api_protocol**. This should
       | always match the respective value of
       | **agave_core_proxy_http_port** or
       | **agave_core_proxy_https_port**
       | in the core configuration section.
   * - **update_apim_core_dns**
     - bool
     - | Whether or not to update the /etc/hosts file with
       | the location of the core services within the APIM
       | container. Use this when the host name/domain for
       | the core services are not in DNS. NOTE: the APIM
       | now routes all requests to
       | ``<tenant_id>.api.<agave_env>.agaveapi.co``
       | so this is the value that must be in DNS.
   * - **core_host**
     - string
     - | IP of the core host. Used only when
       | **update_apim_core_dns** is true.
   * - **deploy_admin_password_grant**
     - bool
     - | Provides a grant type for delegating credentials on
       | behalf of other users.
   * - **access_token_validity_time**
     - string
     - | Time, in seconds, that OAuth access_tokens are valid.
   * - **apim_increase_global_timeout**
     - bool
     - | Whether or not to increase the APIM's global
       | timeout config for APIs to respond. For very
       | large file uploads, it is possible that the
       | APIs will time out before responding to APIM,
       | resulting in a 502. However, setting this to
       | True will increase the timeout for *all* APIs.
       | It will be possible to just increase the files
       | API timeout in a future release.
   * - **deploy_custom_oauth_app**
     - bool
     - | Whether to deploy a custom-branded version of the
       | OAuth login application. If true, install the
       | ``authenticationendpoint`` application (in a
       | directory with the same name) within the tenant
       | directory.
   * - **boutique_apis**
     - string
     - | (Optional). A YAML list of API names from the
       | catalog of extended APIs available in the platform
       | (e.g., admin_services). Each API must be defined
       | as a template in the boutique_apis role, and the
       | name listed must match the name of the template
       | file minus the extension (e.g. ``admin_services``
       | for ``admin_services.json.j2``).

   * - **ha_deployment**
     - bool
     - | For use in h/a deployments of the auth component
       | requiring multiple hosts. Value True will deploy
       | an HA Proxy instance on each auth host to
       | facilitate an active-active architecture. Requires
       | additional configuration, see below.
       |
       | *Note: `ha_deployment=True` is required, as the
       | deployment playbooks currently depend on it.
   * - **hap_servers**
     - string
     - | YAML mapping of servers to use for HAProxy. At
       | least two entries are required, though it is
       | possible to run both servers on the same host
       | using IP addresses and ports on the Docker0
       | interface
       |
       | Each entry must have the following properties:
       | * **name**: Name for the server; must be unique.
       | * **ip**: IP for the server, addressable by the
       | * **port**: Http port for the httpd instance for
       |   this server. Must be reachable by
       |   the HAProxy container(s).
       | * **ssl_port**: Https port for the httpd instance
       |   for this server. Must be reachable by the
       |   HAProxy container(s).

   * - **mysql_host**
     - string
     - | The host of the Auth MySQL server
   * - **mysql_port**
     - string
     - | The port of the Auth MySQL server

   * - **use_hosted_id**
     - bool
     - | Whether or not to use Agave hosted identity
       | services. Cannont be used when the ``use_hosted_id``
       | setting is True. Use this config when Agave will
       | be administering its own LDAP.
   * - **use_remote_userstore**
     - bool
     - | Whether to configure a remote userstore. Use this
       | config when the LDAP will be administered by a
       | third party.
       | * Cannot be used when the* **use_hosted_id**
       | *setting is True. Currently, this configuration*
       | *supports read only LDAP databases.*
   * - **agave_id_read_only**
     - bool
     - | Whether the hosted id service should run in read
       | only mode.
   * - **hosted_id_domain_name**
     - string
     - | A unique id for the agaveldap hosted userstore.
       | *Use this config when Agave will be administering*
       | *its own LDAP.*
   * - **remote_id_domain_name**
     - string
     - | A unique id for the remote userstore.
       | *Use this config when the LDAP will be administered*
       | *by a third party.*
   * - **ldap_name**
     - string
     - | URL or service discovery token for the hosted LDAP
       | instance (including port).
   * - **auth_ldap_bind_dn**
     - string
     - | Account to bind to the LDAP db.
   * - **ldap_base_search_dn**
     - string
     - | Base search directory for user accounts.
   * - **agave_id_check_jwt**
     - string
     - | Whether or not to check the JWT; When this is False,
       | certain features will not be available such as the
       | "me" lookup feature since these features rely on
       | profile information in the JWT.
   * - **jwt_header**
     - string
     - | Actual header name that will show up in
       | request.META; value depends on APIM
       | configuration, in particular the tenant id
       | specified in api-manager.xml.
   * - **agave_id_apim_pub_key**
     - string
     - | Absolute path to the public key of the APIM
       | instance; used for verifying the signature of the
       | JWT.
   * - **agave_id_user_admin_role**
     - string
     - | Role required to make updates to the LDAP database.
   * - **agave_id_check_user_admin_role**
     - bool
     - | Whether or not the ``agave_id_user_admin_role``
       | before allowing updates to the LDAP db.
   * - **agave_id_app_base**
     - string
     - | Sets the base URL for the hypermedia responses;
       | Typically this should be the same as host but
       | should include the protocol.
   * - **cert_file**
     - string
     - | Should be a path relative to the httpd directory
       | contained within the tenant directory for this
       | tenant: e.g. ``deploy/tenants/dev_staging/httpd``
   * - **cert_key_file**
     - string
     - | Should be a path relative to the httpd directory
       | contained within the tenant directory for this
       | tenant.
   * - **ssl_ca_cert_file**
     - string
     - | Add when mounting in a CA cert (not used for
       | self-signed certs). Should be a path relative to
       | the httpd directory contained within the tenant
       | directory for this tenant.
   * - **use_custom_ldap**
     - bool
     - | Use this setting when using a remote userstore
       | and the ldap has a different schema then the hosted
       | Agave LDAP (for example, the iPlant and TACC LDAPs).
       | *Note: Only certain schemas are supported. See the*
       | `agaveplatform/pyprofiles-api`_ Github repo for more
       | details.

   * - **agave_id_create_notifications**
     - bool
     - | Whether or not the auth services should send
       | notifications to beanstalk (see settings below).
       | The auth services must have access to the
       | beanstalk IP and port.
   * - **beanstalk_server**
     - string
     - | IP address of beanstalk instance.
   * - **beanstalk_port**
     - string
     - | Port of beanstalk instance.
   * - **beanstalk_tube**
     - string
     - | Beanstalk tube name that the auth services will send
       | messages to.
   * - **beanstalk_srv_code**
     - string
     - | Code for the service to use when generating messages.
       | There is one code per core service.
   * - **tenant_uuid**
     - string
     - | The UUID of the tenant; this is only used by the
       | components when sending messages to beanstalk.

   * - **virtualhosts**
     - string
     - | A yaml list of collections for configuring the
       | virtualhosts that the auth services will listen
       | on. Defining multiple configuration collections
       | allows the tenant auth server to respond to multiple
       | domains (e.g. ``agave.example.com`` and
       | ``sandbox.tenants.dev.agaveplatform.org``). Each
       | configuration collection should define the
       | following fields:
       | * **server_name**: The domain to respond to.
       | * **base_cert_path**: The directory inside the
       |   httpd container that will hold the certs. This
       |   can be anything, and the agave_id container
       |   will create the directory if it does not exist,
       |   but it must be defined.
       | * **cert_file**: The cert file used by httpd;
       |   this file must be installed within the ``httpd``
       |   folder within the tenant folder.
       | * **cert_key_file**: The cert key file used by
       |   httpd; this file must be installed within the
       |   ``httpd`` folder within the tenant folder.
       | * **ssl_ca_cert_file**: The CA bundle file used
       |   by httpd; this file must be installed within the
       |   ``httpd`` folder within the tenant folder.

   * - **deploy_admin_services**
     - bool
     - | Whether to deploy the tenant admin services
       | (Defaults to True).
   * - **boutique_apis**
     - string
     - | (Optional) A YAML list of strings representing
       | additional APIs to deploy. Each API in the list
       | should be an API recognized by the ``boutique_apis``
       | role. These are the officially supported boutique
       | APIs. Additional APIs can be added to a the set
       | of officially supported APIs by simply adding an
       | <api>.json.j2 template to the
       | ``roles/boutique_apis/templates``
       | directory. The JSON should be formatted as
       | required by the Admin services ``/apis`` service.
       |
       | *Note: this role requires the admin services to*
       | *be deployed on the auth host.*

.. _agaveplatform/pyprofiles-api: https://github.com/agaveplatform/pyprofiles-api

