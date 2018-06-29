*************
Core Concepts
*************


Introduction
============

This section refers to the ``deploy`` directory which contains scripts and other files used for deploying components of Agave.
Deployment is accomplished with Ansible playbooks; Ansible 2.0+ is required. We recommend `installing and running from source`_.
(When running from source, make sure you activate the Ansible environment).

.. note:: A docker image containing all deployment files from this repository as well as the required version of Ansible is now
          available from the docker hub. The image is ``agaveplatform/deployer`` and image tags correspond to tags in this repository.
          The image will be kept up to date as changes are made. We highly recommend using the image instead of trying to run from source.


Why Should I Use The Agave Platform?
====================================


======================  ============================
  I am a...​	             Links to relevant topics
======================  ============================
 Scientist                |togo|_
 Developer                |developer docs|_
 System Administrator     `Setting up a Sandbox`_
======================  ============================
..  Technology Evaluator     Evaluator Checklist
    Director                 What is the Agave Platform
    ======================  ============================

.. _Evaluator Checklist: ../Organizational%20Guide/#evaluator-checklist
.. _What is the Agave Platform: ../Organizational%20Guide/#what-is-the-agave-platform