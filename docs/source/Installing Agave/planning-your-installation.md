## Planning your installation


### Introduction to Installing Agave

To install Agave in production environments, Agave provides an installation method (the installer) implemented using Ansible playbooks. Familiarity with Ansible is assumed, however this installation guide will provide you with the information to help you create an inventory file that represents your environment and desired Agave Platform configuration, then run the installation using the Ansible CLI tooling.

```eval_rst
.. note:: You can read more about Ansible and its basic usage in the [official documentation](http://docs.ansible.com/ansible/).
```

### Initial Planning
When installing the Agave Platform for a production environment, several factors influence installation. Consider the following questions as you read through this guide:

* What kind of traffic do you anticipate receiving? The [Sizing Considerations](#sizing-considerations) section provides limits for hosts and containers based on traffic type and duration so you can calculate how large your environment needs to be.

* How much data do you plan to move through the platform? The [Sizing Considerations](#sizing-considerations) section provides limits for hosts and containers based on data access and throughput so you can calculate how large your environment needs to be.

* What are the nature and duration of the computation you intend to run through Agave? The [Sizing Considerations](#sizing-considerations) section provides guidelines for hosts and containers based on job throughput so you can determine how large your environment needs to be.

* How many hosts do you require in the cluster? The [Environment Scenarios](#environment-scenarios) section provides multiple examples of Single Master and Multiple Master configurations.

* Is high availability (HA) for the platform or science API services required? High availability is recommended for fault tolerance. In this situation, you might aim to use the [Multiple Auth hosts Using Native HA, Multiple Core service hosts, and Clustered Persistence](#multiple-auth-hosts-using-native-ha-multiple-core-service-hosts-and-clustered-persistence) example as a basis for your environment.

* Which identity provider do you use for authentication? If you already use a supported identity provider, it is a best practice to configure Agave's Auth components to use that identity provider during installation.

### On-premises Versus Cloud Providers
Agave can be installed on-premises or hosted on public or private clouds. Ansible playbooks can help you with automating the provisioning and installation processes. For information, see Running Installation Playbooks.

### Sizing Considerations
Determine the nature and duration of the traffic, data, and computation your tenant is expected to support. Concurrent API requests, data movement, and job throughput influences the number of hosts and containers you will need in your setup. See [Platform Limits](platform-limits.html) for the latest guidelines on capacity planning for your tenant.

### Environment Scenarios
This section outlines different examples of scenarios for your Agave environment. Use these scenarios as a basis for planning your own Agave Platform deployment, based on your sizing needs.

```eval_rst
.. note:: Moving from a single auth host to HA after installation is not supported by the deployer at this time.
```

For information on updating labels, see Updating Labels on Nodes.

#### Auth, Core, and Persistence Components on One System
Agave can be installed on a single system for a development environment only. An all-in-one environment is not considered a production environment and should not be attempted on a laptop.

#### Auth and Persistence on a Single System, Core on Multiple Systems
The following table describes an example environment for a single auth host (with persistence services co-located) and two core nodes:

```eval_rst
+-------------------------------------+---------------------------------------------------+
| Host Name                           | Infrastructure Component to Install               |
+=====================================+===================================================+
| auth.agave                          | Auth + persistence                                |
+-------------------------------------+---------------------------------------------------+
| api.core.agave                      | Science API frontend services                     |
+-------------------------------------+---------------------------------------------------+
| worker.core.agave                   | Science API backend worker                        |
+-------------------------------------+---------------------------------------------------+
```

#### Single Auth, Single Persistence, and Multiple Core Systems
The following table describes an example environment for a single auth system, single persistence system, and two core API systems:

```eval_rst
+-------------------------------------+---------------------------------------------------+
| Host Name                           | Infrastructure Component to Install               |
+=====================================+===================================================+
| auth.agave                          | Auth                                              |
+-------------------------------------+---------------------------------------------------+
| db.agave                            | Persistence                                       |
+-------------------------------------+---------------------------------------------------+
| api.core.agave                      | Science API frontend services                     |
+-------------------------------------+---------------------------------------------------+
| worker.core.agave                   | Science API backend worker                        |
+-------------------------------------+---------------------------------------------------+
```

```eval_rst
.. note:: This is the minimum recommended production configuration.
```  

#### Multiple Auth hosts Using Native HA, Multiple Core service hosts, and Clustered Persistence
The following describes an example environment for two load balanced Auth systems running native HA, a standalone realtime service for websocket notfications, 2 independent 3 host MariaDB clusters, 3 host sharded MongoDB cluster, 3 host RabbitMQ cluster with mirrored queues, three load balanced Science API systems, and 2 backend Science API workers systems. 

```eval_rst
+-------------------------------------+----------------------------------------------------+
| Host Name                           | Infrastructure Component to Install                |
+=====================================+====================================================+
| apim[1-2].auth.agave                | Auth with native HAP load balancer                 |
+-------------------------------------+----------------------------------------------------+
| lb.auth.agave                       | Auth load balancer                                 |
+-------------------------------------+----------------------------------------------------+
| realtime.auth.agave                 | Cloud hosted streaming + push notification service |
+-------------------------------------+----------------------------------------------------+
| mongo[1-3].nosql.agave              | MongoDB Shard, Collection, and Mongos Replica Set  |
+-------------------------------------+----------------------------------------------------+
| auth[1-3].db.agave                  | Auth MariaDB cluster                               |
+-------------------------------------+----------------------------------------------------+
| core[1-3].db.agave                  | Core MariaDB cluster                               |
+-------------------------------------+----------------------------------------------------+
| rabbit[1-3].queue.agave             | Message Queue                                      |
+-------------------------------------+----------------------------------------------------+
| lb.core.agave                       | Science API load balancer                          |
+-------------------------------------+----------------------------------------------------+
| api[1-3].core.agave                 | Science API frontend services                      |
+-------------------------------------+----------------------------------------------------+
| worker[1-2].core.agave              | Science API backend worker                         |
+-------------------------------------+----------------------------------------------------+
```

```eval_rst
.. warning:: Clustering and management of MongoDB, RabbitMQ, and MariaDB are beyond the scope of this document. 
``` 

#### Multiple Auth hosts Using Native HA, Multiple Core service hosts, and Clustered Persistence
The following describes an example environment for HA Auth with external IS, APIM, and tenant services, a standalone realtime service for websocket notfications, 2 independent 3 host MariaDB clusters, 3 host sharded MongoDB cluster, 3 host RabbitMQ cluster with mirrored queues, three load balanced Science API systems, and 2 backend Science API workers systems. 

```eval_rst
+-------------------------------------+----------------------------------------------------+
| Host Name                           | Infrastructure Component to Install                |
+=====================================+====================================================+
| apim[1-2].auth.agave                | Auth with native HAP load balancer                 |
+-------------------------------------+----------------------------------------------------+
| is[1-2].auth.agave                  | IS + Key manager                                   |
+-------------------------------------+----------------------------------------------------+
| gateway[1-2].auth.agave             | Gateway traffic manager                            |
+-------------------------------------+----------------------------------------------------+
| api.auth.agave                      | Tenant services                                    |
+-------------------------------------+----------------------------------------------------+
| lb.auth.agave                       | Auth load balancer                                 |
+-------------------------------------+----------------------------------------------------+
| realtime.auth.agave                 | Cloud hosted streaming + push notification service |
+-------------------------------------+----------------------------------------------------+
| mongo[1-3].nosql.agave              | MongoDB Shard, Collection, and Mongos Replica Set  |
+-------------------------------------+----------------------------------------------------+
| auth[1-3].db.agave                  | Auth MariaDB cluster                               |
+-------------------------------------+----------------------------------------------------+
| core[1-3].db.agave                  | Core MariaDB cluster                               |
+-------------------------------------+----------------------------------------------------+
| rabbit[1-3].queue.agave             | Message Queue                                      |
+-------------------------------------+----------------------------------------------------+
| lb.core.agave                       | Science API load balancer                          |
+-------------------------------------+----------------------------------------------------+
| api[1-3].core.agave                 | Science API frontend services                      |
+-------------------------------------+----------------------------------------------------+
| worker[1-2].core.agave              | Science API backend worker                         |
+-------------------------------------+----------------------------------------------------+
```

#### Multiple Auth hosts Using Native HA, Multiple Core service hosts, and Hosted Persistence
The following describes an example environment for HA Auth with external IS, APIM, and tenant services, a standalone realtime service for websocket notfications, 2 independent 3 host MariaDB clusters, 3 host sharded MongoDB cluster, 3 host RabbitMQ cluster with mirrored queues, three load balanced Science API systems, and 2 backend Science API workers systems. 

```eval_rst
+-------------------------------------------+----------------------------------------------------+
| Host Name                                 | Infrastructure Component to Install                |
+===========================================+====================================================+
| apim[1-2].auth.agave                      | Auth with native HAP load balancer                 |
+-------------------------------------------+----------------------------------------------------+
| is[1-2].auth.agave                        | IS + Key manager                                   |
+-------------------------------------------+----------------------------------------------------+
| gateway[1-2].auth.agave                   | Gateway traffic manager                            |
+-------------------------------------------+----------------------------------------------------+
| api.auth.agave                            | Tenant services                                    |
+-------------------------------------------+----------------------------------------------------+
| api[1-3].core.agave                       | Science API frontend services                      |
+-------------------------------------------+----------------------------------------------------+
| worker[1-2].core.agave                    | Science API backend workers                        |
+-------------------------------------------+----------------------------------------------------+

+-------------------------------------------+----------------------------------------------------+
| Host Name                                 | Hosted infrastructure component                    |
+===========================================+====================================================+
| auth-1234567890.region.elb.amazonaws.com  | Auth load balancer                                 |
+-------------------------------------------+----------------------------------------------------+
| core-1234567890.region.elb.amazonaws.com  | Science API load balancer                          |
+-------------------------------------------+----------------------------------------------------+
| 12345.fanout.io                           | Cloud hosted streaming + push notification service |
+-------------------------------------------+----------------------------------------------------+
| atlas.us-east-1.compute.amazonaws.com     | Atlas Managed MongoDB cluster                      |
+-------------------------------------------+----------------------------------------------------+
| mariadb.12345.us-east-1.rds.amazonaws.com | Shared Amazon RDS MariaDB cluster                  |
+-------------------------------------------+----------------------------------------------------+
| mq-aws-eu-west-1-1.iron.io                | IronMQ Message Queue                               |
+-------------------------------------------+----------------------------------------------------+

```

### File Path Locations
All Agave Platform configuration files are placed in `/home/apim` directory during installation and will survive os upgrades. Unless logging is configuration to write to syslog, log data will be written to the `/var/log/agave` directory, and managed via the _logrotate_ utility.

### Storage Requirements
Agave's Science APIs can, at times, cache significant data to the local disk during transfers and transformation requests. The data will be written to the `/home/apim/scratch` directory and cleaned up after each operation. Ensure that you have enough space on the root file system before deploying the Science APIs, or configure an alternative location to use as scratch space. See the System Requirements section for details.

