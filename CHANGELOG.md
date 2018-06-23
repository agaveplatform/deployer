# Change Log
All notable changes to this project will be documented in this file.

## 0.5.0 - 2017-04-21
### Added
- Added support for deploying core services onto multiple hosts configured using a git repository of compose templates.
- (DesignSafe JupterHub) Add the community data source volume mount.
- Several JupyterHub convenience scripts were added for deploying/updating with a single command.
- Added support for ``clean_host`` which, when true, will remove all service account files (``/home/apim``), all Ansible temp files, and all containers. This fixes some issues with ``deploy_agave.plbk`` that could be seen when running subsequent times on a given set of hosts.
- The ``boutique_apis`` role has been added to ``new_tenant.plbk`` and ``deploy_agave.plbk``.
- Password reset routes were added to the auth httpd image, for use when deploying the Account Creation web app.
- A new ``docker_cleanup`` role and corresponding playbook were added.

### Changed
- Fixed an issue with the core sql migrations.
- jupyterhub_worker.plbk now pre-downloads new user notebook images.
- Converted the hubs to the new taccsciapps/jupyterhub images that leverage semantic versioning.
- The location of core config files has changed to accommodate deploying from a core compose git repository or from using the default templates.
- Changed ``deploy_agave.plbk`` to add test accounts after the rolling deployment, Fixing a bug.
- (AD-1231) - Updated boutique_apis role to recoginze the new ``path`` variable in the AdminServices ``/apis`` service, instead of the ``context`` variable.

### Removed
- No change.



## 0.4.5 - 2017-02-13
### Added
- (AD-805) Added support for boutique_apis config for deploying platform extensions such as Abaco or the Admin services.
- (AD-1202) Added support for configuring the profiles image by tenant.

### Changed
- (AD-814) Replaced symbolic link to APIs in the apim container with a Docker volume mount to compiled core API templates living on the host.

### Removed
- No change.


## 0.4.4 - 2017-01-18
### Added

### Changed
- Updated agave core service version to 2.1.10.
- Updated core service compose templates with `uuids`, `tags`, and `realtime` configs.
- Updated apache core service proxy with port mappings for `uuids`, `tags`, `transfers`, `events`, and `realtime` APIs.

### Removed
- No change.


## 0.4.3 - 2017-01-17
### Added

### Changed
- Fixed issue (AD-1163) where multipart POST requests from certain clients such as curl were failing with 417 errors.
- Increasing compose timeout to fix (AD-1038) occasional compose "Read timed out" error trying to remove containers.

### Removed
- No change.


## 0.4.2 - 2017-01-11
### Added
- No change.

### Changed
- Fixed issue (AD-1035) where empty tenant apis directories were causing issues in the automated deployer builds since
they weren't showing up in git.

### Removed
- No change.


## 0.4.1 - 2017-01-02
### Added
- Versioning has been added to all auth service images and they have been moved to the agaveapi organization on docker hub.
- A new tenant, sgwi, has been added for the Science Gateways Institute.
- Several inventory files, such as all_hosts, were added and/or updated.
- Complete, configurable profiles (first and last name, phone numbers, etc.) were added for all the test accounts.
- New swarm_join.plbk to add remote workers to an existing cluster. 
- (AD-1020) added the new SHA2 InCommon cert to apim trust store.
- Added auth deployment logging to a file on the auth host.
- Added a remove_all_auth_containers option to the agave_auth role for cleanly rebuilding the server.
 
### Changed
- Fixed an issue (AD-896) where missing links to the admin services would prevent the auth services from starting properly.
- Fixed an issue (AD-935) where API proxies failed to properly requests with full URLs (http://...) in the URL path.
- Fixed an issue (AD-993) where mysql load scripts which could remove other tenant mysql accounts. 
- Use log driver for smtp in staging.
- Updated logrotate config to use maxage directive.

### Removed
- No change.


## 0.4.0 - 2016-010-23
### Added
- Configurable deployment of initial beta release of first two tenant admin services (service accounts and roles).
- Several new roles and playbooks for provisioning VMs on Openstack, deploying Agave instances and validating
 deployments.
- Ensure APIM public key deployed and served from auth instance (/apim/publickey).
- Configs for abaco API to public tenant.
- New static HAP config when a simple proxy load balancer is needed.
- New tenants route in the auth layer enabling usage in, for example, Agave ToGo.
- Support for clustered network storage via NFS; flexible, generic client and server roles.
- Support for deploying Docker 1.11 Swarm clusters via manager and worker roles.
- Support for clustered JupyterHub deployment via Docker Swarm.
- New Jupyter host files supporting clustered deployments.
- Support for persistent user storage volumes in JupyterHub via configurable network storage.
- Custom overrides for uid and gid of Jupyter user in the hub (for use with network storage).
- Private docker registry support for core apis.
- New roles to push Redis and PushPin for the core services.
- tags, uuid, and realtime apis to core service deployment.

### Changed
- Fix username and app name for DS tenant oauth app.
- Move public auth infrastrcture to UTDC.
- Deploy admin password grant across all production tenants.
- Simplified JupyterHub deployment, reducing total number of config files needed.
- Update to APIM build to fix outdated JDK package.
- Fixed duplicate settings for `agave_core_monitor_min_check_interval`. Defaulting to 0.
- Default version of core apis, `agave_core_version` to 2.1.9
- Max connections in mysql on single db host to 300
- Removed explicit image pulling in `pull_images.sh.j2` and replaced with a `docker-compose pull` for the `proxy` and `a.yml` files.
- Updated core api compose files to honor private registry.
- Updated dev_staging tenant deployment to push and pull from a private registry by default.
- Fixed Atmosphere base URL definitions for CyVerse tenant.
- Fixed bug where auth Apache httpd container could not resolve direct calls to core services when core server not in DNS.
- Updated auth httpd build to new apt packages.

### Removed
- Several auth compose files related to the Serfnode project no longer being used.
- Tenant-specific jupyterhub_config.py.


## 0.3.5 - 2016-07-01
### Added
- New jenkins hosts file.
- Agave branded OAuth app is now bundled with apim image; configs updated accordingly.
- Atmo and Terrain APIs to iPlant prod deployment.
- New Thalemine API definition, certs, truststore and configs for AIP.
- New core config to control minimum interval between monitor checks.

### Changed
- Cleaned up hosts files to prevent Ansible reporting playbooks as failed when they had succeeded (AD-457).
- Fixes to core metadata deployment and new config options.
- Updates to core mongo settings and metadata connection properties to add consistency across deployer.
- Fix max allow packet errors from mysql.
- Updates to documentation in several playbooks.

### Removed
- The default OAuth application has been removed, as it is now bundled with the apim image.
- The deploy/update_default_oauth_app config has been removed as these are no longer options.


## 0.3.4 - 2016-05-25
### Added
- Automatic install of NTP.
- Newrelic role (RHEL only).
- production_base.plbk to install all base software used on TACC-hosted production servers.

### Changed
- Bundle Ansible source directly in image since relying on specific tags from the repository broke things over time.
- Update to the splunk role to use a specific forwarder archive bundled with deployer and to increase idempotence.
- Fixes to iReceptor hap configs.
- Updates to the Adama API definition to use a new host in ec2 and turn off API suspensions.
- Fixes to public.agaveapi.co host and httpd server configs to prefer the public.agaveapi.co domain (changes had not been ported
from docker_atim)

### Removed
- Docker version detection code (agave_auth role) which was no longer in use and breaking some playbooks when running from Jenkins.


## 0.3.3 - 2016-05-20
### Added
- No change.

### Changed
- Turned off API suspension behavior with correct configs for all core APIs.

### Removed
- No change.


## 0.3.2 - 2016-05-19
### Added
- Parameterized the agave_core_sql_migrations role with core_docker_registry_account and core_docker_private_registry
variables.
- Added core_migrations.plbk playbook

### Changed
- Integrated the core sql migration role into existing playbooks.

### Removed
- No change.


## 0.3.1 - 2016-05-18
### Added
- Added optional configurations core_docker_registry_account and core_docker_private_registry for retrieving core API
containers, enabling development builds to be pulled from a private registry or dev account.

### Changed
- No change

### Removed
- No change.


## 0.3.0 - 2016-05-18
### Added
- Core services LB Proxy is now an optional deployment and not deployed by default.
- Several new optional configurations for the core science APIs are available; e.g. mem limits, paging configs, relay transfer.
- Added configs to all core APIs to turn off API suspension behavior.
- Added the Agave branded OAuth app.
- Added the AIP branded OAuth app.
- Expose option to launch Jupyterhub user containers in privileged mode and other Docker host config options.

### Changed
- Core service deployment updates to accommodate 2.1.8 release.
- Added HAP configs for remaining production auth tenants.
- Fixed bug where the default oauth app could get copied to the host unnecessarily.
- Updates to the Designsafe branded OAuth app for responsiveness.
- Update to the directories mounted in the Designsafe hub user containers.

### Removed
- No change.


## 0.2.0 - 2016-04-29
### Added
- Added support for A/B deployments of auth services and a rolling update playbook for (near) zero downtime deployments.
- Added a custom Agave-branded OAuth login application that ships, be default, for each tenants.
- Added a playbook to update Docker installation and auth services simultaneously.
- Added support for A/B deployment of core services.
- Added a role to support sql migrations for the core services.
- Added config files for centos7 sandbox deployment.
- Added support for multiple Agave Jupyterhub instances. Deployment and updates can now done from a configuration directory/
- Added a Jupyterhub update playbook.
- Added support for runtime configuration of all aspects of the Jupyterhub (had previously been baked into the image).
- Added support for custom login page for Jupyterhub.

### Changed
- Disabled chunk transfer encoding from Files, Jobs, Postits and Transforms.
- Changes to the DS custom OAuth login application.
- Added httpbin cert support to APIM.
- Numerous fixes to the core deployment to keep pace with the latest developments.
- Docker role and playbook now deploys precise versions of the tools.
- Moved core and auth mysql container to the official mysql image.
- Updated Jupyterhub projects to build from the latest Jupyterhub releases.
- Jupyterhub images are now under the taccsciapps docker hub organization.
- Fixed wildcard cert issue an vanity DNS preference issue in AIP configs.

### Removed
- Removed various linking behavior in the auth compose files.


## 0.1.1 - 2016-03-29
### Added
- Added support for deploying swagger definition files from auth apache container.

### Changed
- No change.

### Removed
- No change.


## 0.1.0 - 2016-03-19
### Added
- Project CHANGELOG.md file.
- Added support for deploying core APIs using A/B deployment.

### Changed
- Deploying core services now requires a configuration file similar to the tenant config.yml file. See docs for required fields.

### Removed
- No change.
