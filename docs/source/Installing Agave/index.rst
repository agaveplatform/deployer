## Planning your Installation





********************
Introduction
********************



********************
Prerequisites
********************



Selecting Hosts
====================


Bare metal
----------



Static Virtual Machines
-----------------------


Public Cloud
------------



Private Cloud
-------------


********************
Introduction
********************


Introduction
====================

The Agave Platform has multiple installation methods available, each of which allow you to get your own Agave Platform instance up and running. Depending on your environment, you can choose the installation method that works best for you.

For deploying a larger, production ready Agave Platform, see the Installing Agave guide.


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

- Configures each of the hosts, updates local DNS, and configures logging,

- Downloads the appropriate Agave Platform and third party images on each host,

- Bootstraps the databases and installs admin and test user accounts.

- Starts up the containers on each host.

- Completes registration fo the Science APIs


What’s Next?
^^^^^^^^^^^^

Now that you have Agave Platform successfully running in your environment, try it out by running the `run_postman.plbk` playbook.

Method 2: Using the Agave Deployer image
-----------------------------------------

The Agave Deployer is available as a Docker image, ``agaveplatform/deployer``, in the public Docker Hub Registry. The image contains a prebuilt environment with all the necessary dependencies to build and run all the Agave Deployer Playbooks.

Installing and Running the Agave Deployer Docker Image
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Download the image from the Docker Hub.


.. code-block:: bash

    $ docker pull agaveplatform/deployer

Run the deployer with your updated hosts file and ssh private key volume mounted into the container

.. code-block:: bash

    $ docker run -it --rm --name deployer \
             -v $HOME/.vagrant.d/insecure_private_key:/root/.ssh/id_rsa:ro
             -v deploy/host_files/sandbox_hosts:/etc/ansible/hosts
             agaveplatform/deployer deploy_agave.plbk

This command:

- Configures each of the hosts, updates local DNS, and configures logging,

- Downloads the appropriate Agave Platform and third party images on each host,

- Bootstraps the databases and installs admin and test user accounts.

- Starts up the containers on each host.

- Completes registration fo the Science APIs

What’s Next?
^^^^^^^^^^^^

Now that you have Agave Platform successfully running in your environment, try it out by running the `run_postman.plbk` playbook.


Running Postman Validate Suite
==============================

To verify your installation, a collection of Postman tests are included with the Deployer. In order to run the tests, you will need a server with a publicly accessible ip address to which Agave can connect for job and data tests. For basic sandbox installations, you can run the `storage_server.plbk` playbook to start up a Docker container on your auth host that will act as a temporary SSH server for testing.  

..

    Do NOT do this on production hosts. Use a separate host specifically provisioned for testing to run against. The Deployer can easily provision hosts on EC2 and OpenStack for this purpose with the `os_create_host.plbk` Playbook. 
    

To kick off the tests by running the `run_postman.plbk`.

.. code-block:: bash

    $ ansible-playbook -i deploy/host_files/sandbox_hosts run_postman.plbk


The tests will run and output a summary table of the results. Machine readable test results are availble in json, xlm, and html in the `deploy/tmp/agave-postman-test*/reports` directory.

j