***************************
Customizing Inventory Files
***************************

Ansible inventory files describe the details about the hosts in your platform deployment, as well as the component configuration details for your Agave Platform installation. The Agave Platform installation playbooks read your inventory file to know where and how to install Agave Platform components across your set of hosts.

.. note:: See `Ansible documentation`_ for details on the format of an inventory file, including basics on YAML syntax.

When you checkout the Agave Platform installer the a sample inventory file is included at the ``deploy/host_files/sandbox_hosts``. This file is simply the default sandbox host file and has no custom configuration set. To successfully install Agave, you must replace the default contents of the file with your own desired configuration per your host topography and performance requirements.

The following sections describe commonly used variables to set in your inventory file during platform installation. Many of the Ansible variables described are optional. Accepting the default values for required variables should suffice for development environments, but for production environments, it is recommended you read through and become familiar with the various options available.

You can review `Example Inventory Files`_ for various examples to use as a starting point for your Agave Platform installation.

.. _Ansible documentation: https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html
.. _Example Inventory Files: ./example-inventory-files.html


Configuring Agave Platform Variables
=====================================

To assign environment variables during the Ansible install that apply more globally to your Agave Platform installation, indicate the desired variables in the inventory file on separate, single lines within the ``[docker-hosts:vars]`` section. For example:

::

    [docker-hosts:vars]

    tenant_id=sandbox

    agave_core_smtps_provider=sendgrid


.. note:: If a parameter value in the Ansible inventory file contains special characters, such as "#", "{" or "}", you must double-escape the value (that is enclose the value in both single and double quotation marks). For example, to use "mypasswordwith###hashsigns" as a value for the variable ``agave_core_smtps_user_password``, declare it as ``"'agave_core_smtps_user_password='"mypasswordwith###hashsigns"'`` in the Ansible host inventory file.

.. include:: ./auth-component-variables.rst
.. include:: ./core-component-variables.rst


Configuring Agave Platform Secrets
=====================================

Several secrets are configurable by the Ansible installer for the Auth and Core components. The following sections list those variables and their locations.

.. danger:: A sample password file is provided for your reference. In practice, you should encrypt the password file using ansible-vault. The installer will automatically decrypt the file when it runs, thereby keeping your secrets safe.

.. include:: ./auth-component-secrets.rst
.. include:: ./core-component-secrets.rst

