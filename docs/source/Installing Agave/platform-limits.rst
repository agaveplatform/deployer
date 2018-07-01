***************
Platform Limits
***************

This topic summarizes the limits for components in the Agave Platform.

In most cases, exceeding these thresholds results in lower overall performance. In the case of data and job containers, the containers will likely fail and restart, resulting in excessive attempts to copy a file item before eventual success.

Unless otherwise specified, limits are per container. Addition of more containers should result in near linear scaling. 

There are many factors that influence the stated thresholds, including the Docker version, storage driver, network and disk performance, and SQL database tuning.

Agave Platform Limits

Auth Components
================

A detailed performance evaluation can be found in the `WSO2 API Manager Performance and Capacity Planning`_ article. Generally speaking, the APIM will only become a bottleneck when large amounts of data are being directly uploaded and downloaded through the various data APIs. For normal API request traffic, the APIM will easily handle thousands of requests a second, which is generally much higher than the concurrency rate of individual Science API containers.

.. note:: For more information on performance tuning the WSO2 AM, consult the official `Performance Tuning Guide`_.

Science API Frontend Service Components
========================================

The Science API frontend services run in individual Docker containers. The individual services are implemented in a variety of languages including Java, PHP, Python, and node.js. Several services leverage a work queue to process asynchronous tasks as part of their normal operation. The following table assumes the backend workers are deployed independently of the frontend services. This is the situation in the example `4 host production deployment`_ recommended for minimal production deployments.

+---------------------+-----------------------+
| Limit Type          | v2.2.6 Limit          |
+=====================+=======================+
| Apps                | 1.0 CPU, 2GB Memory   |
+---------------------+-----------------------+
| Files               | 2.0 CPU, 2GB Memory   |
+---------------------+-----------------------+
| Jobs                | 2.0 CPU, 2GB Memory   |
+---------------------+-----------------------+
| Logging             | 0.5 CPU, 512MB Memory |
+---------------------+-----------------------+
| Metadata            | 1.0 CPU, 1GB Memory   |
+---------------------+-----------------------+
| Monitors            | 0.5 CPU, 1GB Memory   |
+---------------------+-----------------------+
| Notifications       | 0.5 CPU, 1GB Memory   |
+---------------------+-----------------------+
| PostIts             | 0.5 CPU, 1GB Memory   |
+---------------------+-----------------------+
| Realtime            | 1.0 CPU, 1GB Memory   |
+---------------------+-----------------------+
| Stats               | 0.5 CPU, 1GB Memory   |
+---------------------+-----------------------+
| Systems             | 0.5 CPU, 2GB Memory   |
+---------------------+-----------------------+
| Tags                | 0.5 CPU, 1GB Memory   |
+---------------------+-----------------------+
| Tenants             | 0.5 CPU, 512MB Memory |
+---------------------+-----------------------+
| Transforms          | 1.0 CPU, 2GB Memory   |
+---------------------+-----------------------+
| Usage               | 0.5 CPU, 512MB Memory |
+---------------------+-----------------------+
| UUIDs               | 0.5 CPU, 1GB Memory   |
+---------------------+-----------------------+


Science API Backend Worker Components
=====================================

The Science API backend workers run in individual Docker containers. The containers generally contain Java applications which process the tasks placed onto one or more work queues by the frontend APIs. Each container can be configured to run multiple threads, each capable of processing one task at a time. 

Increasing the number of tasks for a given container should linearly increase the throughput of the work queue. 

It is more desirable to increase the tasks for a given container than start another container. 

+-------------------------------------+---------------------------------------------------+
| Limit Type                          | v2.2.6 Limit                                      |
+=====================================+===================================================+
| Job Staging                         | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| Job Archiving                       | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| Job Submission                      | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| Job Monitoring                      | 0.25 CPU, 512MB Memory per task                   |
+-------------------------------------+---------------------------------------------------+
| File Transfer                       | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| File Transform                      | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| Transform Staging                   | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| Transform Encoding                  | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| Monitor Check                       | 0.5 CPU, 512MB Memory per task                    |
+-------------------------------------+---------------------------------------------------+
| Notification Processor              | 0.25 CPU, 256MB Memory per task                   |
+-------------------------------------+---------------------------------------------------+
| App Cloning                         | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+
| App Publishing                      | 0.5 CPU, 1GB Memory per task                      |
+-------------------------------------+---------------------------------------------------+

.. note:: All worker containers have a 600MB base footprint that should be considered in addition to the above limits.


Planning Your Environment According to Traffic Limits
=====================================================

Oversubscribing the physical resources on a host can negatively impact the performance of the services. The greatest bottleneck when running the Science API frontend services is host memory. While planning your environment, determine the amount of traffic you anticipate receiving and scale your environment accordingly. Generally speaking, the default container settings will support about 20 requests/second for most services. The Jobs, Files, and Transforms services are dependent upon the response time of remote storage systems, so their throughput could be significantly lower. 

 
Planning Your Environment According to Disk Limits
==================================================

Data movement is the single largest load put on your hosts by the Science APIs. The worker containers use a local scratch space on disk for smaller file transfers and data transformation. Ensuring that you have not oversubscribed the available host disk is critical to avoid accidentally filling up the file system and locking the host. 

::

    total_number_of_data_container =
         ((agave_core_transforms_max_staging_tasks + agave_core_transforms_max_transform_tasks) * transform_worker_container_count) +
         ((agave_core_apps_max_cloning_tasks + agave_core_apps_max_publishing_tasks) * app_worker_container_count) +
         ((agave_core_files_max_transform_tasks + agave_core_files_max_staging_tasks) * file_worker_container_count) +
         (agave_core_job_max_submission_tasks + agave_core_job_max_archiving_tasks + agave_core_job_max_staging_tasks) * job_worker_container_count)


The minimum scratch disk (GB) needed is then calculated as the number of containers that could potentially be concurrently copying data plus a 20% buffer. 

::

    total_scratch_disk = (total_number_of_data_container * agave_core_max_relay_transfer_size) * 1.2


Planning Your Environment According to Memory Limits
====================================================

Similarly, for larger file operations, Agave performs data transfers in memory using streaming buffers. This initially creates a large memory overhead per transfer thread. The JVM within a container may not have an accurate picture of the available disk or memory on the host prior to accepting a transfer request, so deadlock, out of memory exceptions, and container crash and restart are possible. While all tasks will be rolled back and picked up by another container or by the original container upon restart, the time and resources originally spent transferring the data are lost. If for no other reason than efficiency, it is best to avoid oversubscribing the backend workers and ensure they have ample disk, memory, and cpu available to operate with a cushion.

Using the values from the `Science API Backend Worker Components`_ section, we can calculate the memory we will need for a worker host.

::

    minimum_worker_container_memory_mb =
         (( agave_core_transforms_max_staging_tasks + agave_core_transforms_max_transform_tasks ) * transform_worker_container_count * 1024) +
         (( agave_core_apps_max_cloning_tasks + agave_core_apps_max_publishing_tasks ) * app_worker_container_count * 1024) +
         (( agave_core_files_max_transform_tasks + agave_core_files_max_staging_tasks ) * file_worker_container_count * 1024) +
         (( agave_core_job_max_submission_tasks + agave_core_job_max_archiving_tasks + agave_core_job_max_staging_tasks ) * job_worker_container_count * 1024) +
         ( agave_core_job_max_monitoring_tasks * job_worker_container_count * 512 ) +
         ( agave_core_notifications_max_notification_tasks * notifications_worker_container_count * 256 ) +
         ( agave_core_monitors_max_tasks * monitors_worker_container_count * 512 )


We then need to calculate the base memory footprint for each worker container:

::

    base_worker_container_memory_footprint_mb = (
        transform_worker_container_count +
        app_worker_container_count +
        file_worker_container_count +
        job_worker_container_count +
        notifications_worker_container_count +
        monitors_worker_container_count ) * 256


The minimum memory (GB) needed is then calculated as the number of containers that could potentially be concurrently copying data plus a 20% buffer.  

::

    base_worker_container_footprint =
        (minimum_worker_container_memory_mb + base_worker_container_memory_footprint_mb) / 1024

.. warning:: This should be recomputed for each host based on the configuration for that particular host.

**Example**: Calculating worker host memory from the `Setting up a Sandbox`_ quickstart guide.

>>> agave_core_transforms_max_staging_tasks = 1
... agave_core_transforms_max_transform_tasks = 1
... transform_worker_container_count = 0
... agave_core_apps_max_cloning_tasks = 1
... agave_core_apps_max_publishing_tasks = 1
... app_worker_container_count = 0
... agave_core_files_max_transform_tasks = 1
... agave_core_files_max_staging_tasks = 7
... file_worker_container_count = 1
... agave_core_job_max_submission_tasks = 2
... agave_core_job_max_archiving_tasks = 5
... agave_core_job_max_staging_tasks = 7
... agave_core_job_max_monitoring_tasks = 1
... job_worker_container_count = 1
... agave_core_notifications_max_notification_tasks = 1
... notifications_worker_container_count = 0
... agave_core_monitors_max_tasks = 1
... monitors_worker_container_count = 0
>>> minimum_worker_container_memory_mb = (( agave_core_transforms_max_staging_tasks + agave_core_transforms_max_transform_tasks ) * transform_worker_container_count * 1024) + (( agave_core_apps_max_cloning_tasks + agave_core_apps_max_publishing_tasks ) * app_worker_container_count * 1024) + (( agave_core_files_max_transform_tasks + agave_core_files_max_staging_tasks ) * file_worker_container_count * 1024) + (( agave_core_job_max_submission_tasks + agave_core_job_max_archiving_tasks + agave_core_job_max_staging_tasks ) * job_worker_container_count * 1024) + ( agave_core_job_max_monitoring_tasks * job_worker_container_count * 512 ) + ( agave_core_notifications_max_notification_tasks * notifications_worker_container_count * 256 ) + ( agave_core_monitors_max_tasks * monitors_worker_container_count * 512 )
>>> base_worker_container_memory_footprint_mb = ( transform_worker_container_count + app_worker_container_count + file_worker_container_count + job_worker_container_count + notifications_worker_container_count + monitors_worker_container_count ) * 256
>>> base_worker_container_footprint = (minimum_worker_container_memory_mb + base_worker_container_memory_footprint_mb) / 1024
>>> print (round(base_worker_container_footprint), "GB",sep="")
23GB



Planning Your Environment According to CPU Limits
=================================================

If your data transfer operations will include compression or be domiated by the use of protocols requiring encryption (SFTP, FTPS, HTTPS, etc.), then CPU load should also be taken into consideration when planning your environment. We can again use the values from the `Science API Backend Worker Components`_ section to calculate the CPU count needed for a worker host.


::

    minimum_worker_container_cores =
         (( agave_core_transforms_max_staging_tasks + agave_core_transforms_max_transform_tasks ) * transform_worker_container_count * .5) +
         (( agave_core_apps_max_cloning_tasks + agave_core_apps_max_publishing_tasks ) * app_worker_container_count * .5) +
         (( agave_core_files_max_transform_tasks + agave_core_files_max_staging_tasks ) * file_worker_container_count * .5) +
         (( agave_core_job_max_submission_tasks + agave_core_job_max_archiving_tasks + agave_core_job_max_staging_tasks ) * job_worker_container_count * .5) +
         ( agave_core_job_max_monitoring_tasks * job_worker_container_count * .25 ) +
         ( agave_core_notifications_max_notification_tasks * notifications_worker_container_count * .25 ) +
         ( agave_core_monitors_max_tasks * monitors_worker_container_count * .5 )


The minimum core count needed is then calculated as the ``minimum_worker_container_cores`` plus an overhead for system services.

::

    minimum_worker_host_cores = minimum_worker_container_cores + 1.5


**Example:** Calculating worker host core count from the `Setting up a Sandbox`_ quickstart guide.

>>> minimum_worker_container_cores = (( agave_core_transforms_max_staging_tasks + agave_core_transforms_max_transform_tasks ) * transform_worker_container_count * .5) + (( agave_core_apps_max_cloning_tasks + agave_core_apps_max_publishing_tasks ) * app_worker_container_count * .5) + (( agave_core_files_max_transform_tasks + agave_core_files_max_staging_tasks ) * file_worker_container_count * .5)  + (( agave_core_job_max_submission_tasks + agave_core_job_max_archiving_tasks + agave_core_job_max_staging_tasks ) * job_worker_container_count * .5) + ( agave_core_job_max_monitoring_tasks * job_worker_container_count * .25 ) + ( agave_core_notifications_max_notification_tasks * notifications_worker_container_count * .25 ) + ( agave_core_monitors_max_tasks * monitors_worker_container_count * .5 )
>>> print(minimum_worker_container_cores, " cores", sep="")
11.25 cores


.. warning:: This should be recomputed for each host based on the configuration for that particular host.


.. _`Setting up a Sandbox`: ../Getting%20Started/sandbox.html
.. _`4 host production deployment`: planning-your-installation.html#single-auth-single-persistence-and-multiple-core-systems
.. _`Performance Tuning Guide`: https://docs.wso2.com/display/AM190/Tuning+Performance
.. _`WSO2 API Manager Performance and Capacity Planning`: https://docs.wso2.com/display/AM220/WSO2+API-M+Performance+and+Capacity+Planning