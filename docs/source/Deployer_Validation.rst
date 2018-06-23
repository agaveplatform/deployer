===================
Deployer Validation
===================

Deployer validation is performed by creating three VMs to host the Agave services:

 - Auth Stack
 - Core Service Stack
 - Persistence Stack

The validation functionality is implemented in an Ansible playbook, ``validate_deployer.plbk``. Currently dynamic
provisioning and inventory is only supported on OpenStack.

Requirements
------------

The minimum instance sizes for each host group are:

+------------+------+------------+----------+
| Host Group |  CPU | Memory(GB) | Disk(GB) |
+============+======+============+==========+
| auth       |   4  |      8GB   |   60GB   |
| core       |   4  |     16GB   |   60GB   |
| db         |   4  |      8GB   |   60GB   |
+------------+------+------------+----------+




Components
==========

Accounts
--------

A valid OpenStack account is required. The standard ``openstack.rc`` variables are supported. You may enter one or more variables as command line arguments when running the playbook. The playbook will prompt you for any parameters not explicitly entered at runtime. If you have initialized your openstack environment file, the playbook variables will default to the values in your environment.

The minimum instance sizes for each host group are:

+------------+------+------------+----------+
| Host Group |  CPU | Memory(GB) | Disk(GB) |
+============+======+============+==========+
| auth       |   4  |      8GB   |   60GB   |
| core       |   4  |     16GB   |   60GB   |
| db         |   4  |      8GB   |   60GB   |
+------------+------+------------+----------+


Host Files
----------

The ``validate_deployer.plbk`` relies on a single host file which will be used to define the host groups to which the dynamic inventory will be associated. Do not edit this host file as playbook uses a dynamic inventory based on the instances currently available through your openstack account.


Roles
-----

The basic functionality of the playbook is identical to that of the ``deploy_agave.plbk`` playbook, but tasks to manage a dynamic inventory have been added prior to the deployment being run. After deployment completes, three additional roles are run to validate the functionality of the platform.

  - ``admin_service_tests`` - Run smoke tests over admin services
  - ``core_service_tests`` - Run smoke tests over core services
  - ``realtime_tests`` - Run smoke tests over realtime services

Test output will be written to standard out and saved in machine parsable description within /output directory upon completion.

Configuration Files
-------------------

Configuration files for this playbook are identical to the ``Deploy.rst`` playbook.