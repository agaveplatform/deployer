*******************
System Requirements
*******************


The following sections identify the hardware specifications and system-level requirements of all hosts within your OpenShift Origin environment.

Minimum Hardware Requirements
=============================

The system requirements vary per host type:

+----------------------+-------------------------------------------------------------------------------------+
| Host Type            | System Requirements                                                                 |
+======================+=====================================================================================+
| auth                 | | * Physical or virtual system, or an instance running on a public or private IaaS. |
|                      |                                                                                     |
|                      | | * Base OS: CentOS 7.4.                                                            |
|                      |                                                                                     |
|                      | | * Minimum 4 vCPU (additional are strongly recommended).                           |
|                      |                                                                                     |
|                      | | * Minimum 8 GB RAM (additional memory is strongly recommended, especially if      |
|                      | | streaming and push notification service is co-located on auth).                   |
|                      |                                                                                     |
|                      | | * Minimum 20 GB hard disk space for the file system containing /var/.             |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing /usr/local/bin/.    |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing the system’s        |
|                      | | temporary directory.                                                              |
|                      |                                                                                     |
|                      | | * An additional minimum 60 GB unallocated space per system running containers     |
|                      | | for Docker’s storage back end; see Configuring Docker Storage. Additional         |
|                      | | space might be required, depending on the size and number of containers that      |
|                      | | run on the node.                                                                  |
+----------------------+-------------------------------------------------------------------------------------+
| core                 | | * Physical or virtual system, or an instance running on a public or private IaaS. |
|                      |                                                                                     |
|                      | | * Base OS: CentOS 7.4.                                                            |
|                      |                                                                                     |
|                      | | * Minimum 8 vCPU (additional are strongly recommended).                           |
|                      |                                                                                     |
|                      | | * Minimum 16 GB RAM (additional memory is strongly recommended, especially if     |
|                      | | both worker and service containers are running on the host).                      |
|                      |                                                                                     |
|                      | | * Minimum 20 GB hard disk space for the file system containing /var/.             |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing /usr/local/bin/.    |
|                      |                                                                                     |
|                      | | * Minimum 100 GB hard disk space for the file system containing /home.            |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing the system’s        |
|                      | | temporary directory.                                                              |
|                      |                                                                                     |
|                      | | * An additional minimum 60 GB unallocated space per system running containers     |
|                      | | for Docker’s storage back end; see Configuring Docker Storage. Additional         |
|                      | | space might be required, depending on the size and number of containers that      |
|                      | | run on the node.                                                                  |
+----------------------+-------------------------------------------------------------------------------------+
| persistence          | | * Physical or virtual system, or an instance running on a public or private IaaS. |
|                      |                                                                                     |
|                      | | * Base OS: CentOS 7.4.                                                            |
|                      |                                                                                     |
|                      | | * Minimum 6 vCPU (additional are strongly recommended). [1]_ [2]_                 |
|                      |                                                                                     |
|                      | | * Minimum 8 GB RAM (additional memory is strongly recommended, especially if      |
|                      | | streaming and push notification service is co-located on auth).                   |
|                      |                                                                                     |
|                      | | * Minimum 20 GB hard disk space for the file system containing /var/.             |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing /usr/local/bin/.    |
|                      |                                                                                     |
|                      | | * Minimum 60 GB hard disk space for the file system containing /home.             |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing the system’s        |
|                      | | temporary directory.                                                              |
|                      |                                                                                     |
|                      | | * An additional minimum 20 GB unallocated space per system running containers     |
|                      | | for Docker’s storage back end; see Configuring Docker Storage. Additional         |
|                      | | space might be required, depending on the size and number of containers that      |
|                      | | run on the node.                                                                  |
+----------------------+-------------------------------------------------------------------------------------+
| web                  | | * Physical or virtual system, or an instance running on a public or private IaaS. |
|                      |                                                                                     |
|                      | | * Base OS: CentOS 7.4.                                                            |
|                      |                                                                                     |
|                      | | * Minimum 2 vCPU (additional are strongly recommended).                           |
|                      |                                                                                     |
|                      | | * Minimum 4 GB RAM (additional as needed with web traffic).                       |
|                      |                                                                                     |
|                      | | * Minimum 20 GB hard disk space for the file system containing /var/.             |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing /usr/local/bin/.    |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing the system’s        |
|                      | | temporary directory.                                                              |
|                      |                                                                                     |
|                      | | * An additional minimum 20 GB unallocated space per system running containers     |
|                      | | for Docker’s storage back end; see Configuring Docker Storage. Additional         |
|                      | | space might be required, depending on the size and number of containers that      |
|                      | | run on the node.                                                                  |
+----------------------+-------------------------------------------------------------------------------------+
| postman              | | * Physical or virtual system, or an instance running on a public or private IaaS. |
|                      |                                                                                     |
|                      | | * Base OS: CentOS 7.4.                                                            |
|                      |                                                                                     |
|                      | | * Minimum 2 vCPU                                                                  |
|                      |                                                                                     |
|                      | | * Minimum 4 GB RAM.                                                               |
|                      |                                                                                     |
|                      | | * Minimum 20 GB hard disk space for the file system containing /var/.             |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing /usr/local/bin/.    |
|                      |                                                                                     |
|                      | | * Minimum 1 GB hard disk space for the file system containing the system’s        |
|                      | | temporary directory.                                                              |
|                      |                                                                                     |
|                      | | * An additional minimum 40 GB unallocated space per system running containers     |
|                      | | for Docker’s storage back end; see Configuring Docker Storage. Additional         |
|                      | | space might be required, depending on the size and number of containers that      |
|                      | | run on the node.                                                                  |
+----------------------+-------------------------------------------------------------------------------------+

.. [1] See `MongoDB production notes`_
.. [2] See `MariaDB performance tuning`_


Production Level Hardware Requirements
======================================

Test or sample environments function with the minimum requirements. For production environments, the following recommendations apply:

**Auth Hosts**
In a highly available Agave Platform deployment, an Auth component host should have, in addition to the minimum requirements in the table above, 2 CPU core and 4 GB of memory for the shared file system and synchronization taskss. Therefore, the recommended size of an Auth component host would be the minimum requirements of 4 CPU cores and 8 GB of RAM, plus 2 CPU cores and 4 GB of RAM, totaling 6 CPU cores and 12 GB of RAM.

See the `Platform Limits`_ section for more information.

**Core Hosts**
The size of a core host depends on the expected size of its workload. As an Agave Platform administrator, you will need to calculate the expected workload, then add about 20 percent for bursting and overhead. For production environments, allocate enough resources so that a single container failure does not affect your maximum capacity.

For more information, see `Sizing Considerations`_ and `Platform Limits`_.


**Persistence Hosts**
In a production environment, the size of the persistence host depends on the requirements of the database or queue it is hosting. The persistence components should never be deployed on a single host in a production environment. At the minimum, they should each be run on their own host and managed independently by an experience database administrator.

More information on clustering and tuning MariaDB, MongoDB, and RabbitMQ can be found on their respective websites.


Environment Requirements
========================

The following section defines the requirements of the environment containing your Agave Platform deployment. This includes networking considerations and access to external services, such as Git repository access, storage, and cloud infrastructure providers.

DNS Requirements
----------------
The Agave Platform requires a publicly resolvable hostnames for each host. Within the platform, this can be managed through the setting of `/etc/hosts` files on the hosts. For production environments, valid DNS entries for each host should be created and included in the inventory files.

By default, containers receive their DNS configuration file (/etc/resolv.conf) from their host. For the Science API data services and workers, passive communication channels often need to be configured to complete file operations. In these cases it it important that the host has a publicly resolvable ip address that the container knows about and can be accessed from the outside world. For this reason, the inventory files should include the ip of the host rather than hostname as the value of each host's ``ansible_ssh_host`` variable.

If you do not have a properly functioning DNS environment, you could experience failure with:

* Installation via the reference Ansible-based scripts
* Resolution of PostIts url from the Science APIs
* Third-party transfers over FTP, SFTP, and GridFTP.
* Download of files through their public URLs.
* Communication between the API Manager and backend services.

Network Access Requirements
===========================

A shared network must exist between the master and node hosts. If you plan to configure multiple masters for high-availability using standard cluster installation process, you must also select an IP to be configured as your virtual IP (VIP) during the installation process. The IP that you select must be routable between all of your nodes, and if you configure using a FQDN it should resolve on all nodes.

Required Ports
--------------
.. The Agave Platform installation automatically creates a set of internal firewall rules on each host using iptables. However, if your network configuration uses an external firewall, such as a hardware-based firewall, you must ensure infrastructure components can communicate with each other through specific ports that act as communication endpoints for certain processes or services.

The Agave Platform installation delegates firewall management to the host and Docker Engine. If your network configuration uses an external firewall, such as a hardware-based firewall, you must ensure infrastructure components can communicate with each other through specific ports that act as communication endpoints for certain processes or services.

Ensure the following ports required by Agave are open on your network and configured to allow access between hosts. Some ports are optional depending on your configuration and usage.

.. note:: (L) indicates the marked port is also used in loopback mode, enabling the master to communicate with itself.

.. list-table:: Auth to World
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 80, 443
     - TCP
     - Required for basic web traffic

.. list-table:: Auth to Auth
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 8080 (L)
     - TCP
     - Required for communication with API Pubisher and Store
   * - | 8443 (L)
       | 9000
     - TCP
     - Required for communication with API Pubisher and Store
   * - 9000 (L)
     - TCP
     - Required for profile service configuration during deployments

.. list-table:: Auth to Core
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 80, 443
     - TCP
     - Required for HTTP traffic to the backend APIs

.. list-table:: Auth to Persistence
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 389
     - TCP
     - Required for LDAP access
   * - 3301
     - TCP
     - Required for access to Auth MariaDB instance
   * - 11300
     - TCP
     - Required for beanstalkd access

.. list-table:: Core to World
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 52920-52940
     - TCP
     - Optional JMX ports for stats and remote debugging
   * - 30000-30111
     - TCP
     - Optional passive data channel port range for FTP and FTPS connections
   * - | 50000-50999
       | 52900-52999
     - TCP
     - Optional passive data channel port ranges for GridFTP connections

.. list-table:: Core to Core
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 80 or 443 (L)
     - UDP
     - Required for load balanced communication between core hosts
   * - 8440-8499 (L)
     - TCP
     - Required for HTTP requests within a Host
   * - 8070-8099 (L)
     - TCP
     - Required for TLS requests within a Host

.. list-table:: Core to Persistence
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 389
     - TCP
     - Required for LDAP access
   * - 3301
     - TCP
     - Required for access to Auth MariaDB instance
   * - 3306
     - TCP
     - Required for access to Core MariaDB instance
   * - 9000
     - TCP
     - Required for access to MongoDB access
   * - 11300
     - TCP
     - Required for beanstalkd access

.. list-table:: Persistence to Persistence
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 3306, 3301
     - TCP
     - MariaDB client access
   * - 4567
     - UDP, TCP
     - | MariaDB replication traffic, multicast replication uses both UDP transport
       | and TCP on this port.
   * - 4568
     - TCP
     - MariaDB incremental state updates
   * - 4444
     - TCP
     - Misc state transfer updates
   * - 27017
     - TCP
     - Primary MongoDB mongos/mongod port
   * - 27018
     - TCP
     - Primary MongoDB shard server port
   * - 27019
     - TCP
     - Primary MongoDB config server port
   * - 9000
     - TCP
     - MongoDB client access

.. list-table:: IaaS Deployments
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 22
     - TCP
     - Required for SSH by the installer or system administrator.

.. list-table:: Aggregated Logging
   :widths: 20 10 70
   :header-rows: 1

   * - Port(s)
     - Traffic
     - Description
   * - 9200 (L)
     - TCP
     - | Optional: For Elasticsearch API use. Required to be internally open on any
       | infrastructure nodes so Kibana is able to retrieve logs for display.
   * - 9880
     - TCP
     - Optional: fluentd HTTP port
   * - 24224
     - TCP
     - Optional: fluentd forwarder


Persistent Storage
==================

Persistent storage is configured by default through volume mounts onto the component hosts. For multi-host deployments, Docker volumes are used to mount MFS storage into the containers.


Cloud Provider Considerations
=============================

There are certain aspects to take into consideration if installing OpenShift Origin on a cloud provider. Consult the respective could provider security group documentation for more information on how to configure the above port ranges for access in your environment.

.. note:: For OpenStack deployments, the ``os_create_hosts.plbk`` playbook will configure the appropriate security groups for you.



.. _MongoDB production notes: https://docs.mongodb.com/manual/administration/production-notes/#prod-notes-ram
.. _MariaDB performance tuning: https://severalnines.com/resources/webinars/our-guide-mysql-mariadb-performance-tuning
.. _Sizing Considerations: ../Installing%20Agave/planning-your-installation.html#sizing-considerations
