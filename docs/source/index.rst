.. CoTIM documentation master file, created by
   sphinx-quickstart on Fri Jun 12 11:01:03 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Agave Platform Tenant Infrastructure Management Documentation
=============================================================

Contents:

.. toctree::
   :maxdepth: 4
   :hidden:

   Introduction
   Getting Started/index
   Architecture/index

   Security Guide/*
..      Container security
      Private registries
      Configuration management
      Network security
      Shared storage
      Securing data
      Monitoring events and logs
      Managing secrets

   Installing Agave/*
..      Installation
      Requirements
      Building
      Quickstarts/*
         Sandbox

   Upgrading Agave/*
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

   Configuring Agave/*
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

   Agave Administration/*
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

   Scaling and Performance Guide/*
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

   Organizational Guide/*
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








Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

