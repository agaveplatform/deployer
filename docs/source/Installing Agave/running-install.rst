******************************
Running Installation Playbooks
******************************

Before Initiating Installation
==============================

Before installing Agave Platform, you must first:

* See the Prerequisites_ and `Host Preparation`_ topics to prepare your hosts. This includes verifying system and environment requirements per component type and properly installing and configuring the Docker service. It also includes installing Ansible version 2.4 or later, as the installation method is based on Ansible playbooks and as such requires directly invoking Ansible.

* See the `Configuring Your Inventory File`_ topic to define your environment and desired Agave Platform component configurations. This inventory file will be used to initiate the installation, and should be saved and maintained for future platform upgrades as well.

Cloud installation
==================

Agave Platform VMs can be provisioned in a cloud environment. You can use Ansible playbooks to automate defining of your cloud hosted infrastructure and applying post-provision configuration for the supported cloud providers.

OpenStack Provider
------------------
The Agave Platform installer comes with playbooks for provisioning hosts on an OpenStack cloud and managing them through a dynamic inventory.  See the `Running Individual Component Playbooks`_ section for more information.


Running the Installation Playbooks
==================================
The installer uses modularized playbooks allowing administrators to install specific components as needed. By breaking up the roles and playbooks, there is better targeting of ad hoc administration tasks. This results in an increased level of control during installations and results in time savings. The playbooks and their ordering are detailed below in `Running Individual Component Playbooks`_.

After you have `configured Ansible`_ by defining an inventory file in ``/etc/ansible/hosts``, run the installation playbook via Ansible using either the native ``ansible-playbook``` command or containerized installer.

.. danger:: Do not run Agave Platform playbooks under nohup. Using nohup with the playbooks causes file descriptors to be created and not closed. Therefore, the system can run out of files to open and the playbook will fail.

To run the Agave Platform installerm, run the ``deploy_agave.yml`` playbook to initiate the platform installation. Use the following command, specifying -i if your inventory file located somewhere other than ``/etc/ansible/hosts``.

::

  # ansible-playbook [-i /path/to/inventory] \
      ~/agave-deployer/deploy/deploy_agave.yml

If for any reason the installation fails, before re-running the installer, see `Known Issues`_ to check for any specific instructions or workarounds.

The installer caches playbook configuration values for 10 minutes, by default. If you change any system, network, or inventory configuration, and then re-run the installer within that 10 minute period, the new values are not used, and the previous values are used instead. You can delete the contents of the cache, which is defined by the fact_caching_connection value in the /etc/ansible/ansible.cfg file. An example of this file is shown in Recommended Installation Practices.


Running Individual Component Playbooks
======================================

The main installation playbook ``~/agave-deployer/deploy/deploy_agave.yml`` runs a set of individual component playbooks in a specific order, and the installer reports back at the end what phases you have gone through. If the installation fails during a phase, you are notified on the screen along with the errors from the Ansible run.

After you resolve the issue, rather than run the entire installation over again, you can pick up from the failed phase. You must then run each of the remaining playbooks in order:

::

  # ansible-playbook [-i /path/to/inventory] <playbook_file_location>

The following table is sorted in order of when each individual component playbook is run:

.. list-table:: Individual Component Playbook Run Order
   :widths: 30 50
   :header-rows: 1

   * - Playbook Name
     - File Location
   * - Host Configuration
     - ~/agave-deployer/deploy/docker_host.plbk
   * - MySQL Database Install
     - ~/agave-deployer/deploy/deploy_mysql_db.plbk
   * - NoSQL Database Install
     - ~/agave-deployer/deploy/deploy_nosql_db.plbk
   * - Core Components Install
     - ~/agave-deployer/deploy/deploy_core.plbk
   * - Migrate Core DB
     - ~/agave-deployer/deploy/core_migrations.plbk
   * - Migrate Auth DB
     - ~/agave-deployer/deploy/load_auth_mysql.plbk
   * - Auth Components Install
     - ~/agave-deployer/deploy/deploy_auth.plbk
   * - Default Account Install
     - ~/agave-deployer/deploy/load_ldap_users.plbk
   * - Boutique API Install
     - ~/agave-deployer/deploy/register_boutique_apis.plbk


Verifying the Installation
==========================

After the installation completes:

Check the API Publisher Web Interface
-------------------------------------
Verify that the APIM is running and services are present by opening the Auth component host URL in your web browser. For example, for an Auth host with a host name of sandbox.example.com, the publisher console would be found at https://sandbox.example.com/publisher

Run Postman Tests
-----------------
A suite of Postman tests is bundled with the installer. Before running them, you should add another group to your inventory file containing ``localhost`` and customizing any of the Postman test variables you see fit.

An example inventory file with the Postman config is given below:

::

  [postman:vars]

  # The hostname or ip of the linux server the newman tests will
  # register with Agave and use to run all data and compute tests
  newman_agave_test_system_host=192.168.205.12

  # The sftp port on which Agave should connect to `newman_agave_test_system_host`
  # during the tests
  newman_agave_test_system_port=22

  # The username with which Agave should connect to `newman_agave_test_system_host`
  # during the tests
  newman_agave_test_system_username=vagrant

  # The virtual home directory to use in the system definition when Agave interacts
  # with `newman_agave_test_system_host`
  newman_agave_test_system_homedir=/home/vagrant

  # The public key allowing connections to `newman_agave_test_system_host`
  newman_agave_test_system_public_key_file=~/.ssh/id_rsa.pub

  # The private key Agave should use to connect to `newman_agave_test_system_host`
  newman_agave_test_system_private_key_file=~/.ssh/id_rsa


  [postman]
  localhost ansible_connection=local


Once you have updated your inventory file, you can run the tests by invoking the ``~/agave-deployer/deploy/run_postman.plbk`` playbook.

::

  # ansible-playbook [-i /path/to/inventory] \
      ~/agave-deployer/deploy/run_postman.plbk -l postman


Once the tests complete, you will see a tabular output of the results printed to stdout. Reports in XML, JSON, and HTML are also available in the ``~/agave-deployer/deploy/tmp/agave*/reports`` folder.


Uninstalling The Agave Platform
===============================

You can uninstall Agave hosts in your environment by running the docker_cleanup.yml playbook. This playbook deletes Agave Platform content installed by Ansible, including:

* Configuration
* Containers
* Default templates and volumes
* Images
* Custom logs & loggers
* Service user account
* Service user home directory

The playbook will delete content for any hosts defined in the inventory file that you specify when running the playbook. If you want to uninstall the Agave Platfrom across all hosts in your deployment, run the playbook using the inventory file you used when installing Agave initially or ran most recently:

::

  # ansible-playbook [-i /path/to/inventory] \
      ~/agave-deployer/deploy/docker_cleanup.plbk


When the playbook completes, all Agave Platform content should be removed from any specified hosts.


Known Issues
============

When SELinux is enabled on the host, the installer can choke when fetching data from HTTPS resources. We believe this is due to the python-selinux module not being present in the default python path. To work around this, reboot the host after the first failure and try again.


.. _Prerequisites: ./prerequisites.html
.. _Host Preparation: ./host-preparation.html
.. _Configuring Your Inventory File: ./configuring-your-inventory-file.html
.. _configured Ansible: ./configuring-your-inventory-file.html#configuring-ansible
