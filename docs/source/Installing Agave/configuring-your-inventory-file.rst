********************************************
Customizing Inventory Files for Your Cluster
********************************************

Ansible inventory files describe the details about the hosts in your platform deployment, as well as the cluster configuration details for your OpenShift Origin installation. The OpenShift Origin installation playbooks read your inventory file to know where and how to install OpenShift Origin across your set of hosts.

See Ansible documentation for details on the format of an inventory file, including basics on YAML syntax.

When you install the openshift-ansible-utils RPM package as described in Host Preparation, Ansible dependencies create a file at the default location of /etc/ansible/hosts. However, the file is simply the default Ansible example and has no variables related specifically to OpenShift Origin configuration. To successfully install OpenShift Origin, you must replace the default contents of the file with your own desired configuration per your cluster topography and requirements.

The following sections describe commonly used variables to set in your inventory file during cluster installation. Many of the Ansible variables described are optional. Accepting the default values for required variables should suffice for development environments, but for production environments, it is recommended you read through and become familiar with the various options available.

You can review Example Inventory Files for various examples to use as a starting point for your cluster installation.

Images require a version number policy in order to maintain updates. See the Image Version Tag Policy section in the Architecture Guide for more information.

Configuring Agave Platform Variables
=============================

To assign environment variables during the Ansible install that apply more globally to your Agave Platform installation, indicate the desired variables in the /etc/ansible/hosts file on separate, single lines within the ``[docker-hosts:vars]`` section. For example:

::

    [docker-hosts:vars]

    tenant_id=sandbox

    agave_core_smtps_provider=sendgrid

If a parameter value in the Ansible inventory file contains special characters, such as "#", "{" or "}", you must double-escape the value (that is enclose the value in both single and double quotation marks). For example, to use "mypasswordwith###hashsigns" as a value for the variable ``agave_core_smtps_user_password``, declare it as agave_core_smtps_user_password='"mypasswordwith###hashsigns"' in the Ansible host inventory file.

The following tables describe variables for use with the Ansible installer that can be assigned cluster-wide:

