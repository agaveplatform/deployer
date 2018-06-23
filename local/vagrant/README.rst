
==============================
Local Development With Vagrant
==============================
This directory contains resources that can be used for developing the Ansible scripts locally. The technique involves
using Vagrant to spin up three VMs (one for each of the auth, core and db components) on a private network. All the
details are located in the Vagrantfile within this directory.

To develop locally with Vagrant, you will need a recent version of vagrant installed (tested with 1.7.4, found issues with 1.7.2) as well as the
``centos/7`` box image (for virtualbox). See the Vagrant box downloads page or install directly with

.. code-block:: bash
    
    $ vagrant box add centos/7

Once the prerequisites are installed, start the VMs by executing

.. code-block:: bash
    
    $ vagrant up

from within this directory. There should now be three vm's running on a private network with static IPs as follows:

- ``auth`` - 192.168.205.10
- ``core`` - 192.168.205.11
- ``db`` - 192.168.205.12

Create a hosts file that points to these private IPs and leverages the private keys contained within the ``.vagrant`` directory.
An example ``vagrant_hosts`` file is included in this directory. Exercise the ansible playbooks by referencing this
host file as usual. For example,

.. code-block:: bash

    $ ansible-playbook -i ../local/vagrant/vagrant_hosts deploy_agave.plbk -e tenant_id=sandbox -e load_auth_sql_data=true

For more information on deploying components of Agave with our Ansible playbooks, please see the `documentation`_

If tearing down and recreating the VMs repeatedly, it may be convenient to turn off host key checking by exporting
the following environmental variable.

.. code-block:: bash

    $ export ANSIBLE_HOST_KEY_CHECKING=False
    
To interact with the auth server, be sure to update your hosts file with an entry that resolves the tenant domain to the auth IP.
For example:

.. code-block:: bash

    192.168.205.10 sandbox.agaveplatform.org
    

.. _documentation: https://bitbucket.org/jstubbs/docker_atim/src/c9bc08493e0179dddc9415d06275d62116fb79fa/docs/source/Deploy.rst?at=master&fileviewer=file-view-default