*********
Overview
*********


Agave is designed as a distributed, multi-tenant microservice architecture. Services run in Docker containers and  Docker containers. The platform conceptually breaks down into three logical set of components:

=================== =======================================================
 Component Group     Description
=================== =======================================================
 Authentication      Identity and authentication services, API management,
                     and higher-level administration services.
 Core Science APIs   REST services providing the Science-as-a-Service
                     capabilities to the platform such as job management,
                     data movement, metadata services, app registration,
                     notifications, etc.
 Infrastructure      Persistence and support services.
=================== ======================================


What Is the Agave Platform Architecture?
=========================================

Agave’s multi-tenant capability comes from its ability to securely serve multiple tenants from a single deployment of the platform. A tenant is a group of users, usually representing a community or organization, who share access to a common configuration of the platform. Within a tenant, IAM, data, services, documentation, and global default settings are configured for all users. Typically, a single Agave tenant will support tens to hundreds of client applications and thousands of users with no additional configuration.

Individual tenants can be scaled from a minimal sandbox installation to high-availability, shared installation spanning multiple data centers. Figures 1 shows a basic sandbox deployment of the platform. Roughly 50 containers will be started across 3 hosts. One host for platform services, another for core Science APIs, and another for persistence and infrastructure services.

.. image:: ../images/Agave_Sandbox_Architecture_V2.png

In practice, most tenants do some capacity planning up front, then adjust their static footprint to handle 80-90% of peak throughput at any given moment. Adding additional workers, load balancing the Identity Server, API Manager, and Science APIs, clustering the relational databases, and sharding the nosql server for better capacity and performance are standard steps when operating higher capacity tenants. The architecture in Figure 2 shows a production deployment scaled in this manner across 20+ hosts. With this architecture, upwards of 200 containers would be running at a given time. Given sufficient networking, such a deployment would be capable of moving upwards of a Petabyte of data, managing 100s of thousand of jobs, and serving 10s of millions of requests per day across one or more tenants. It is important to note that while most of these tasks can be automated by the Agave's Deployer playbooks, local database and system administrators should be included in the process.

.. image:: ../images/Agave_Scalable_N_Host_Production_Architecture.png


How Is Agave Secured?
=========================================

The Agave Platform authenticates users who present credentials, and then authorize them based on their role. Both developers and administrators can be authenticated via a number of means, primarily OAuth tokens and JSON Web Tokens. OAuth tokens are signed with JSON Web Algorithm RS256, which is RSA signature algorithm PKCS#1 v1.5 with SHA-256.

Developers (clients of the system) typically make REST API calls from a client program like the Agave SDK, or to Agave ToGo via their browser, and use OAuth bearer tokens for most communications. Science APIs use service accounts and delegated OAuth tokens. Infrastructure components (like boutique APIs and third party-services) use a token associated with their service account to connect to the API.

At the platform level, API authorization is handled at by the WSO2 API Manager and Identity Server. Every API is assigned a set of scopes. Scopes are restricted to users with a specific role. Roles are bound to users or groups by the user or group identifier. When a user or service account makes an API request, API Manager checks for one or more of the roles assigned to the user for the scope associated with the request before allowing it to continue. Each tenant has a dedicated API Manager

The Science APIs each implement their own layer of roles and permissions relevant to the resources they represent. Access is controlled by making API requests to the individual resources. Platform-wide administrative access can be assigned by granting user accounts the `sandbox-services-admin` role at the platform level through the Admin services.

TLS Support
===========
All internal communication with the Agave Platform are secured with TLS. TLS provides strong encryption, data integrity, and authentication of servers with X.509 server certificates and public key infrastructure. By default, a new internal PKI is created for each deployment of OpenShift Origin. The internal PKI uses 2048 bit RSA keys and SHA-256 signatures. Custom certificates for public hosts are supported as well.

Agave's auth components use the Java Cryptography Extension (JCE) implementation of crypto/tls. Agave's load balancer uses openssl version 1.2. The Science APIs also leverage these two implementations for validating token signatures and securing communication between components. The insecure versions SSL 2.0 and SSL 3.0 are unsupported and not available. Cipher suites with deprecated and insecure algorithms such as RC4, 3DES, and MD5 are disabled. Some internal clients (for example, LDAP authentication) have less restrict settings with TLS 1.0 to 1.2 and more cipher suites enabled.