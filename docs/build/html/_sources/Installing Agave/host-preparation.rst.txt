********************
Preparing Your Hosts
********************


Setting PATH
============

The PATH for the root user on each host must contain the following directories:

* /bin
* /sbin
* /usr/bin
* /usr/sbin

These should all be included by default in a fresh CentOS 7.x installation.

Ensuring Host Access
========================

The Agave Platform installer requires a user that has access to all hosts b jcvbp. If you want to run the installer as a non-root user, passwordless sudo rights must be configured on each destination host.

For example, you can generate an SSH key on the host where you will invoke the installation process:

# ssh-keygen
Do not use a password.

An easy way to distribute your SSH keys is by using a bash loop:

.. code:: shell

    # for host in auth.agave  core.agave  db.agave ; do \
          ssh-copy-id -i ~/.ssh/id_rsa.pub $host; \
      done

Modify the host names in the above command according to your configuration.


Installing Base Packages
=========================

The Agave Platform installer will install all necessary packages on the host on first run. On each subsequent run, the installer will ensure the packages are present and up to date. The following packages will be installed:

- libselinux-python
- git
- cronie
- net-tools
- bind-utils
- iftop
- bash-completion
- psacct


Installing Docker
=================

The Agave Platform installer will also install and configure the Docker daemon on the hosts. Only trusted registries are enabled by default. If you will be pulling images from a registry with a self-signed cert, or cert signed by an untrusted CA, you should add the ip address or subnet of any insecure registries you plan to use to the ``docker_insecure_registries`` list variable in your inventory file. This will tell the installer to include those values as ``--insecure-registry`` parameters to the Docker daemon startup command on each host. The --insecure-registry option instructs the Docker daemon to trust any Docker registry on the indicated subnet, rather than requiring a certificate.

::

    ...

    [agave:vars]

    ...

    docker_insecure_registries:
        - 192.168.205.12
        - 192.168.205.0/32
    ...

.. warning:: Once this value is set, changing it will require restarting the Docker service on each host. This will result in all running containers being stopped. Keep this in mind when deciding to use an insecure registry for your images.


Configuring Docker Storage
==========================

The containers running the components of the Agave Platform are stored in Docker’s storage back end. This storage is ephemeral and separate from any persistent storage allocated to meet the needs of your applications. With Ephemeral storage, container-saved data is lost when the container is removed. With persistent storage, container-saved data remains if the container is removed.

The Agave Platform installer configures persistent storage for each system that runs a container daemon. In HA installations, the persistent storage will leverage a NFS mount on each host. In standard installations, container data will be persisted using volume mounts to the host file system.

Managing Container Logs
=======================

The Agave Platform installer will configure Docker to use the ``json-file`` logging driver by default. You can manage this by configuring Docker’s `json-file`_ logging driver to restrict the max log file size to 5MB and a maximum of 5 files.

.. note:: Future versions of the installer will consolidate all logging into a `fluentd`_ forwarder running natively on the host. You will then have the option of consuming the fluentd stream in your preferred tool. Until then, logs are written to local disk and rotated via ``logrotate``.

.. _json-file: https://docs.docker.com/config/containers/logging/json-file/
.. _fluentd: https://www.fluentd.org