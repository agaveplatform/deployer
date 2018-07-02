.. image:: images/agave-platform-logo.png
   :alt: The Agave Platform
   :width: 70%
   :align: center


Introduction
=============

The Agave Platform is a multi-tenant Science-as-a-Service platform empowering users to manage data, run code, collaborate meaningfully, and integrate virtually anything through standards-based REST interfaces. It supports a wealth of different data and authentication protocols, speaks to many different batch schedulers and execution services, and can natively communicate with many 3rd party services and collaboration platforms. Because of the diversity of languages and services it supports, Agave saves you time and money that you can use to innovate the science behind your technology.

.. asdfasdfa
   toctree::
   :maxdepth: 2
   :caption: Welcome
   Introduction

.. toctree::
   :maxdepth: 2
   :caption: Getting Started
   :hidden:

   Getting Started/overview
   Getting Started/sandbox

.. toctree::
   :maxdepth: 2
   :caption: Architecture
   :hidden:

   Architecture/overview
   Architecture/core-concepts
   Architecture/infrastructure-components


.. asdfasdf
    toctree::
   :maxdepth: 2
   :caption: Architecture

..   Security Guide/*
      Container security
      Private registries
      Configuration management
      Network security
      Shared storage
      Securing data
      Monitoring events and logs
      Managing secrets

.. toctree::
   :maxdepth: 2
   :caption: Installing Agave
   :hidden:

   Installing Agave/planning-your-installation
   Installing Agave/prerequisites
   Installing Agave/host-preparation

..      Installation
      Requirements
      Building
      Quickstarts/*
         Sandbox

.. toctree::
   :maxdepth: 2
   :caption: Upgrading Agave
   :hidden:

..   Upgrading Agave/index
..      Hosting and infrastructure
      Tenant Level Services
         API management
         Identity services
      Networking
      Core Science APIs
         Major vs minor releases
         Versioning
         New services
      Boutique APIs
      Persistence
         Managing migrations
         Database updates
         Rolling back the database

.. toctree::
   :maxdepth: 2
   :caption: Configuring Agave
   :hidden:

..   Configuring Agave/index
..      IAM
         Identity providers
            Hosted
            External
         WSO2 AM
         WSO2 ID
         Account creation
         Profiles API
      API Management
         WSO2 AM
         Clients API
         API Registration
      Persistence
         Single Host
            MySQL
            MongoDB
            Message Queue
         Clustering
            MySQL
               - Percona cluster
               - RDS
            MongoDB
               - Sharding
               - MLab
               - AWS: https://docs.aws.amazon.com/quickstart/latest/mongodb/architecture.html
            Message Queue
               - RabbitMQ
               - SQS
      Notifications
         Default providers
         Email
            Providers
            Templates
         Optional providers
            Realtime
            SMS
      Theming
         Login Page
         Store
         Publisher
      Science APIs
         Tenant contacts
         Publishing shared storage and compute
         Publishing application catalog
         Default systems
         Supported Notification methods
         Realtime messaging

..         insert services here

..      Tooling
         ToGo
         Microsites
         SDKs
         CLI

..      Web
         Documentation
         API Explorer
         JSON Mirror
         Changelog Parser

.. toctree::
   :maxdepth: 2
   :caption: Building Images
   :hidden:

   Building Images/index


.. toctree::
   :maxdepth: 2
   :caption: Agave Administration
   :hidden:

..   Agave Administration/*
..      WSO2 AM
..      Admin Services
         Tenant contact info
         Groups and Roles
         Service Accounts
         Client Registration
..      Event subscription and automation
         Account provisioning
         Quotas enforcement
         Billing
         Usage alerts

..      Monitoring
         Self-hosted
            Splunk
            ELK
         SaaS
            Sumo Logic
            Logz.io

..      Logging
         Sources
            Host
            Docker
            Container
         Collectors
            fluentd
            splunk

..      Status reporting
         Prometheus
         CachetHQ

..      Continuous Integration
         Docker images
         Integration tests
         Release management

..      Continuous Delivery
         Rolling updates
         Migrations

..      Configuration management
         Git
         Ansible Vault
         Jenkins secrets

.. toctree::
   :maxdepth: 2
   :caption: Scaling and Performance Guide
   :hidden:

   Scaling and Performance Guide/platform-limits
..      Capacity Planning/*

..      Recommended Host practices

..      Recommended Installation practices

..      Optimizing mysql peformance

..      Optimizing mongodb performance

..      High Availability/*
         Authentication
         API Management
         Core Science APIs
         Persistence
         Web

..      Scaling core science APIs
         Jobs
         Files
         Notifications
         Apps
         Monitors
      Handling large file upload
      Optimizing file transfer throughput
      Optimizing file operation responsiveness

..      Automation/*
         Jenkins
         Tower/AWX

..      Maintenance/*

.. toctree::
   :maxdepth: 2
   :caption: Organizational Guide
   :hidden:

..   Organizational Guide/*
..      What is the Agave Platform
      Evaluator Checklist
      New Adopter Checklist
      Promoting Agave to Decision Makers
      Budget Planning
         Understanding Operational Costs
         Total Cost of Ownership Calculator
      Developer Engagement Program
      Support Channels
         Agave Open Source Community
            Slack
            Github
         Online Documentation
         Self-Guided Online Training
         Workshops & Tutorials
         Partnership








.. Indices and tables
.. ==================
..
.. * :ref:`genindex`
.. * :ref:`modindex`
.. * :ref:`search`

