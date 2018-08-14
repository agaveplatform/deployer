# Agave Ansible Deployer

> This project deploys a sandbox installation of the [Agave Platform](https://agaveapi.co/). This should not be used as-is for production deployments.  

Please see the project [Documentation](https://agaveplatform.github.io/deployer) for detailed guides on deploying the platform.
 
## Table of Contents

- [Install](#install)
- [Security](#security)
- [Usage](#usage)
- [Contribute](#contribute)
- [License](#license)


## Install
The Agave Ansible Deployer's dependencies are managed with pip. Use the included `requirements.txt` file to install them.

```
git clone https://github.com/agaveplatform/deployer.git agave-deployer
cd agave-deployer
pip install -r requirements
```
The Deployer also leverages several public roles from Ansible Galaxy. Use the included `deploy/galaxy.yml` file to install them.

```
cd deploy
ansible-galaxy install -r galaxy.yml
```

Once the dependencies and Ansible Galaxy roles are imported, copy the example password files into place.

```
cp agave_core_configs/sandbox_passwords-example agave_core_configs/sandbox_passwords
cp tenants/sandbox/sandbox_passwords-example tenants/sandbox/sandbox_passwords
```

You are now ready to configure and install a new instance of the Agave Platform. Please consult the [Agave Ansible Deployer Documentation](https://agaveplatform.github.io/deployer) for a detailed instructions.
 
## Security
Sensitive information such as the `sandbox_password` files you copied into place should never be stored in plain text. We recommend using [Ansible Vault](https://docs.ansible.com/ansible/2.5/user_guide/vault.html). To encrypt your password files with Vault, run the following commands. 

> If this is your first time running Vault, you will be prompted for a master pass phrase that will be used to encrypt and decrypt all your files. Do not lose this phrase, as it is required to decrypt your data when you run the various playbooks. 

```
ansible-vault encrypt agave_core_configs/sandbox_passwords tenants/sandbox/sandbox_passwords
```

If you need to edit the files, you can securely do so using Vault. Once you save them, they will be re-encrypted and stored back in their original location. 

```
ansible-vault encrypt agave_core_configs/sandbox_passwords tenants/sandbox/sandbox_passwords
``` 

## Usage

See the [Setting up a sandbox](https://agaveplatform.github.io/deployer/build/html/Getting%20Started/sandbox.html) secion of the documentation for instructions on building, testing, and deploying the Agave Platform.
 
## Contribute

We welcomes contributions from anyone and everyone. Please refer to the project style guidelines and guidelines for submitting patches and additions. In general, we follow the "fork-and-pull" Git workflow.

1. Fork the repo on GitHub
2. Clone the project to your own machine
3. Commit changes to your own branch
4. Push your work back up to your fork
5. Submit a Pull request so that we can review your changes

***NOTE:*** Be sure to merge the latest from "upstream" before making a pull request!

## License

[BSD 3-Clause](../LICENSE)

