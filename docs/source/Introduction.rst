============
Introduction
============

Agave Deployer is the project used to build images and deploy containers that make up the Agave Platform infrastructure. Each tenant
runs its own VM (the "tenant vm") of containers to handle Identity and Access Management (IAM) and API management as well as other third party services.
There are base images for all the services containing paramiterized configurations in the form of Jinja2 templates. Each
tenant supplies configuration values via a yaml file which gets mounted into the containers at deployment time. Before
starting the primary process for a container, the templates are compiled from the values specified in the yaml file.
Note that the base images cannot be run directly without mounting a values.yml file.


## Build ##
With the exception of APIM, all base images are built directly from Dockerfiles that reside in the corresponding
directory within base_images. The APIM image is still built using an Ansible script. The wrapper script,
build_apim_image.sh, will take care of building and tagging the APIM image locally using the underlying Ansible script,
build_app.sh. Once build_apim_image.sh has been run, the resulting image should be pushed to the Docker Hub.


## Creating a New Tenant ##
To create a new tenant, add a directory within deploy/tenants whose name is <tenant id>_<environment> where environment
is one of 'staging' or 'production'. Immediately within that directory, create two files: <name>.yml and
<name>_passwords. <name>.yml contains all public configurations for the tenant while <name>_passwords contains sensitive
data and will remain outside version control. Additionally, create a subdirectory httpd with the apache .crt and .key
files needed. See the dev_staging directory for examples.


## Deploy ##
Deployment of tenant containers is done using Ansible playbooks. This project contains playbooks needed for deploying
and managing containers in staging and production as well as a directory of hosts files used for inventory. There are
two main playbooks: new_tenant.plbk and update_tenant.plbk. In addition to deploying the auth containers, the
new_tenant.plbk will create databases and load data into the configured MySQL database. The update_tenant.plbk will
pull the latest images from Docker Hub, remove all running containers, and start new ones.

