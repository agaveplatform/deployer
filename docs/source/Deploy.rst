Deploying the Platform
======================

For reusability, discrete units of functionality are packaged into Ansible roles contained within the ``roles`` directory within ``deploy`` folder. Additionally,
the project includes several Ansible playbooks representing common operations use cases.

To use existing playbooks, the simplest approach for machines running Docker might be to use the Agave deployer Docker image, ``agaveapi/deployer``. This
image bundles all the Ansible playbooks and roles together with the specific version of Ansible that they require. All tenant configuration
included in the repository is also bundled, though password files and other security sensitive files (e.g. httpd certificate files) are not included. The
entrypoint for the image is ``ansible-playbook``, so running a playbook using the image involves passing the playbook arguments after mounting any
configuration files not already included. The basic format is as follows:

``docker run <volume mounts> agaveapi/deployer -i <hosts file> <playbook>``

There are a couple of points worth noting. First, paths referred to in the ``docker run`` statement are relative to the ``deploy`` directory from within the container. Any files not included in the image must be mounted in to a path relative to this image. Some files that will need to be mounted:
  - ``hosts`` file, if different from the hosts files included in the ``deployer`` repository.
  - ``ssh_keys`` - the keys used to ssh to the hosts are not includes and must be mounted in. NOTE: the host files included in the repository refer to the ssy keys using a relative path: ``~/.ssh/id_rsa``. Since the playbook runs as the container's root user, one can mount the keys to ``/root/.ssh/id_rsa`` and still make use of the existing host files.
  - ``<tenant_id>_passwords`` and ``<environment>_passwords`` - passwords files are not included in the image.
  - any tenant config files that are not included in ``deployer`` repository.

Here is an example invocation where we mount several files into the container:

``docker run --rm -v /home/jdoe/ansible/keys/prod:/root/.ssh/id_rsa  -v /home/jdoe/ansible/tenants/dev_staging/dev_staging_passwords:/deploy/tenants/dev_staging/dev_staging_passwords -v /home/jdoe/ansible/tenants/dev_staging/httpd:/deploy/tenants/dev_staging/httpd agaveapi/deployer -i /deploy/host_files/staging_hosts /deploy/update_tenant.plbk``

More playbooks are continuing to be developed to provide more
functionality out of the box, and developing additional use cases and/or roles should be straight-forward for any developer familiar with Ansible.

We highlight a few roles that are particularly useful.

  - ``agave_host`` - this role provides basic capabilities to the host including creating the linux service account that all Agave services will run under.
  - ``docker_host`` - this role deploys and configures the docker daemon as well as dependent tools such as docker compose.
  - ``agave_auth`` - this role is used to deploy and update an Agave auth component. (Relies on ``agave_host`` and ``docker_host``).
  - ``agave_core`` - this role is used to deploy and update an Agave core component. (Relies on ``agave_host`` and ``docker_host``).
  - ``agave_db_onehost`` - this role deploys the entire Agave persistence layer on a single VM -- not recommended for production. (Relies on ``agave_host`` and ``docker_host``).
  - ``mysql_apim`` - this role configures a mysql database for use by an Agave auth component and pre-loads all necessary users and schemas.
  - ``ldap_apim`` - this role pre-loads an LDAP database with test accounts for use in a sandbox setting.


We highlight a few playbooks that are particularly useful. Specific documentation on usage is available in the playbook file.

  - ``deploy_agave.plbk`` - this playbook deploys all three agave components from scratch on a set of three VMs.
  - ``deploy_core.plbk`` - this playbook deploys the core component on a single VM. It currently requires a core configuration file (see section above) tenant_id, and hosts file since it uses the tenant_id configuration for configuration regarding connectivity with the persistence layer.
  - ``update_core.plbk`` - this playbook updates the core component on a single VM. It currently requires a core configuration file (see section above) tenant_id, and hosts file since it uses the tenant_id configuration for configuration regarding connectivity with the persistence layer.
  - ``new_tenant.plbk`` - this playbook deploys an auth component from scratch. In particular, it loads empty sql schemas for the authorization data and thus, if run on an existing tenant those data will be lost.
  - ``update_tenant.plbk`` - this playbook updates the configuration and containers for the auth component of an existing tenant. It does not touch the persistence layer.

Here are some of the main playbook parameters. Not all apply to all playbooks. See playbook files for specific documentation.
  - ``tenant_id`` - The tenant id to deploy; required for ``deploy_agave.plbk`` since there could be multiple tenants.
  - ``core_config_file`` - The core config file name (without the ``.yml``) to use. Required for ``deploy_agave.plbk`` and ``*_core.plbk``.
  - ``docker_version`` - Use a (newer) version of Docker than the default configured in deployer. This is optional and should be tested before using in production.
  - ``deploy_core_default_templates`` (True/False) - Whether to use the default docker compose templates for the core services (see above). Required for ``deploy_agave.plbk`` and ``*_core.plbk``
  - ``clean_host`` (True/False) - Whether to wipe all service files, Ansible temp files and docker containers on the hosts before running additional scripts. Default is ``False`` -- should not be used on production hosts.



.. _installing and running from source: http://docs.ansible.com/intro_installation.html#installing-the-control-machine
