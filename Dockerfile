##
# Agave Platform Deployer
# Image: agaveplatform/deployer
# Contains the Ansible playbooks needed to deploy and manage the Agave Platform.
# Currently suports deployments to openstack  and static hosts.

FROM ubuntu:16.04

# packages
RUN apt-get update && \
    apt-get install -y python-setuptools python-dev build-essential python-pip libffi-dev libssl-dev git ssh-client

# dependencies for ansible
RUN pip install --upgrade pip
RUN /usr/local/bin/pip install -U paramiko PyYAML Jinja2 httplib2 six pycrypto pytz cryptography
RUN /usr/local/bin/pip install -U shade ansible && \
    mkdir -p /etc/ansible/cache && \
    touch /etc/ansible/ansible.cfg && \
    echo "deprecation_warnings=False" >> /etc/ansible/ansible.cfg

ENV ANSIBLE_HOST_KEY_CHECKING False
ENV ANSIBLE_CACHE_PLUGIN yaml
ENV ANSIBLE_CACHE_PLUGIN_CONNECTION /etc/ansible/cache

ADD ./deploy /deploy

ENTRYPOINT ["ansible-playbook"]

CMD ["-h"]
