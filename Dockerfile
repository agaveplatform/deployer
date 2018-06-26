##
# Agave Platform Deployer
# Image: agaveplatform/deployer
# Contains the Ansible playbooks needed to deploy and manage the Agave Platform.
# Currently suports deployments to openstack  and static hosts.

FROM ubuntu:16.04

# packages
RUN apt-get update && \
    apt-get install -y python-setuptools python-dev build-essential python-pip libffi-dev libssl-dev git ssh-client

ADD ./requirements.txt /deploy/requirements.txt
# dependencies for ansible
RUN pip install --upgrade pip
RUN pip install -r /deploy/requirements.txt && \
    mkdir -p /etc/ansible/cache && \
    touch /etc/ansible/ansible.cfg && \
    echo "deprecation_warnings=False" >> /etc/ansible/ansible.cfg

ENV ANSIBLE_HOST_KEY_CHECKING False
ENV ANSIBLE_CACHE_PLUGIN yaml
ENV ANSIBLE_CACHE_PLUGIN_CONNECTION /etc/ansible/cache

ADD ./deploy /deploy

RUN cp deploy/host_files/sandbox_hosts /etc/ansible/hosts && \
    cp deploy/agave_core_configs/sandbox_passwords-example deploy/agave_core_configs/sandbox_passwords && \
    cp deploy/tenants/sandbox/sandbox_passwords-example deploy/tenants/sandbox/sandbox_passwords

WORKDIR /deploy

ENTRYPOINT ["ansible-playbook"]

CMD ["-h"]
