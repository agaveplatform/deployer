# Agave Deployer #

## Overview ##
This project is used to build images and deploy containers that make up the Agave Platform. An instance of the platform
is made up of servers dedicated to running containers from one of three components:
* Auth - identity and access management services
* Core - core science APIs
* Persistence - Databases, Queues and other Third-Party services
A common, minimal deployment runs the full suite of containers from each component on a dedicated virtual machine (vm).

Agave is a multi-tenant platform, with each tenant running its own, dedicated version of the auth services. This project
houses the necessary tenant-specific configurations needed to deploy those services, Each tenant
runs its own VM (the "tenant vm") of containers to handle auth and API management as well as other third party services.
There are base images for all the services, and then each tenant overlays the base images with special configurations
specific to that tenant. To increase availability in production (or other environments),
multiple instances of the tenant vm can be run behind a load balancer.


## Build ##
All base images for containers used in the Auth layer are built directly from Dockerfiles that reside in the corresponding
directory within base_images. Images are also regularly pushed to the Docker Hub so that deployments can be carried out
without a prerequisite build step.


## Creating a New Tenant ##
To create a new tenant, add a directory within deploy/tenants whose name is <tenant id>. Immediately within that
directory, create two files: <tenant_id>.yml and <tenant_id>_passwords. <tenant_id>.yml contains all public configurations
for the tenant while <tenant_id>_passwords contains sensitive
data and will remain outside version control.

Within the <tenant_id> directory, a directory called `apis` should be created to hold the definition files of any
boutique APIs that are needed.

Finally, create a subdirectory httpd within the <tenant_id> directory with the apache .crt and .key
files needed. See the dev_staging directory for examples.


## Deploy ##
Deployment of tenant containers is done using Ansible playbooks. This project contains playbooks needed for deploying
and managing containers in staging and production as well as a directory of hosts files used for inventory. There are
two main playbooks: new_tenant.plbk and update_tenant.plbk. In addition to deploying the auth containers, the
new_tenant.plbk will create databases and load data into the configured MySQL database. The update_tenant.plbk will
pull the latest images from Docker Hub, remove all running containers, and start new ones.


## Documentation ##
Additional documentation is being developed within the docs directory using Sphinx.