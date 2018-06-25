********************
Setting up a Sandbox
********************


Introduction
====================

The Agave Platform has multiple installation methods available, each of which allow you to get your own Agave Platform instance up and running. Depending on your environment, you can choose the installation method that works best for you.

For deploying a full Agave Platform cluster, see the Installing Agave guide.


Prerequisites
====================

Before choosing an installation method, you must first satisfy the prerequisites on your hosts, which includes verifying system, network, and firewall requirements. After ensuring your hosts are properly set up, you can continue by choosing one of the following installation methods.

The Agave Platform must run on the CentOS 7 operating system. If you wish to run the server from a Windows or Mac OS X host, you should provision the necessary CentOS virtual machines first. A Vagrant file is provided in the ``local/vagrant`` that will provision 3 CentOS 7.2 virtual machines on your local system that you can use for testing.

The Agave Deployer and Docker use iptables to manage networking. Ensure that local firewall rules and other software making iptable changes do not alter the Agave Platform and Docker service setup.

On-premise vs Cloud Providers
-----------------------------

The Agave Platform can be installed on-premise or hosted on public or private clouds. For information, see `Installation Agave`_.

.. _Installing Agave: Installing Agave/#overview

Once you have your cluster nodes provisioned, update the ``deploy/host_files/sandbox_hosts`` file withe the connectivity information of your hosts. You will need to update the ip addresses, path to the private key, and privileged login username on your hosts.

choose the installation method that fits your case the best.

Installation Methods
====================

Choose one of the following installation methods that works best for you.

Method 1: Running the Ansible Playbooks
---------------------------------------

You can quickly get Agave Platform running in a container using images from Docker Hub on a Linux system. This method is supported on Fedora, CentOS, and Red Hat Enterprise Linux (RHEL) hosts only.

    Agave frontend services listen on ports ``80``, ``443``, ``8080``, ``8443`` and ``9000``. Agave backend services listen on 80, 443, 8440-8499, and 8070-8099. If you plan on enabling passive FTP and GridFTP support, Agave utilizes three port ranges to enable this behavior: 30000-31000, 50000-51000, 52900-52999. If another service is already listening on those ports on the respective host(s), you must stop that service before launching the Agave Platform containers.


Starting an All-in-One Server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Start the server:

.. code-block:: bash

    $ ansible-playbook -i deploy/host_files/sandbox_hosts deploy_agave.plbk

This command:

- Configures each of the hosts,

- Installs the Agave Platform components on each host,

- updates DNS and sets up logging,

- Starts the various containers.

- Bootstraps the databases and installes admin and test user accounts.

What’s Next?
^^^^^^^^^^^^

Now that you have Agave Platform successfully running in your environment, try it out by running the `run_postman.plbk` playbook.

Method 2: Using the Agave Deployer image
-----------------------------------------

The Agave Deployer is available as a Docker image, ``agaveplatform/deployer``, in the public Docker Hub Registry. The image contains a prebuilt environment with all the necessary dependencies to build and run all the Agave Deployer Playbooks.

Installing and Running the Agave Deployer Docker Image
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Download the image from the Docker Hub.


::

    $ docker pull agaveplatform/deployer

Run the deployer with your custom hosts file volume mounted into the container

::

    $ docker run -it --rm --name deployer \
             -v deploy/host_files/sandbox_hosts:/etc/ansible/hosts
             agaveplatform/deployer deploy_agave.plbk

This command:

- Configures each of the hosts,

- Installs the Agave Platform components on each host,

- updates DNS and sets up logging,

- Starts the various containers.

- Bootstraps the databases and installes admin and test user accounts.

What’s Next?
^^^^^^^^^^^^

Now that you have Agave Platform successfully running in your environment, try it out by running the `run_postman.plbk` playbook. Make sure you update the ``[postman:vars]`` section of your sandbox_hosts file with the information for the host you want Agave to connect to as a storage/compute system when running the tests.

..
    Prerequisites
    ====================


    Installing Deployer
    ====================


    Deploying a Sandbox Tenant
    ==========================

    Configuring Hosts File
    -----------------------

    Running the Playbook
    --------------------

    Validating Installation
    ------------------------

    Bootstrapping Data
    --------------------


    Deploying Agave ToGo
    =====================


    Configuring Agave Tooling
    =========================
