.. _project_deploy-multi-ec2-rds:

=====================================================================
Project: RDS Multi-Instance Deployment of MapNotes and GeoServer APIs
=====================================================================

Infrastructure Requirements
===========================

For this project you will be deploying the MapNotes and GeoServer APIs to individual EC2 instances. As part of the infrastructure you will be moving from containerized (temporary) databases and into managed RDS instances.

Network
-------

The Network layer of the infrastructure will require two pairs of public and private subnets. Recall that the public subnets will expose the web APIs and the private subnets will be using exclusively for the RDS instances.

Subnets
^^^^^^^

In order to ensure high availability of our data and APIs we will create two pairs of subnets in distinct Availability Zones (AZ) within the VPC Region.

- AZ 1: public and private subnet
- AZ 2: public and private subnet

Security Groups
^^^^^^^^^^^^^^^

The network traffic should be secured with two Security Groups (SG) -- one for public-facing APIs and the other for the internal databases. Remember that you can apply a SG to any number of networked resources like EC2 and RDS instances. The SG name, inbound and outbound rules should be granular to a _common purpose_ like ``PublicWebAPI`` or ``PrivatePostgresDB``.

.. admonition:: Note

  When designing your SGs remember to grant **least privileged access** and consider the following:

  - what is the purpose or role of this type of networked resource?
  - is this type of resource publicly exposed or for internal use?
  - what inbound and outbound traffic does this type of resource expect in order to operate?

You will need the following Security Groups to secure network traffic:

- ``PublicWebAPI``
  - inbound: all HTTP/S traffic
  - outbound: all HTTP/S traffic, PostgreSQL traffic **only** to the ``PrivatePostgresDB`` SG

- ``PrivatePostgresDB``
  - inbound: PostgreSQL traffic **only** from the ``PublicWebAPI`` SG
  - outbound: all HTTP/S traffic

- ``<Location>SSH`` (``<NameHome>SSH``)
  - inbound: SSH traffic from your IP
  - outbound: none

The final ``SSH`` SG is meant for your own SSH access to the machine. It doesn't declare any rules except inbound SSH traffic from your IP. This SG is meant to be added and removed _sparingly_ so it should complement existing SG rules on the resource while not exposing anything beyond its inbound SSH need.

Compute
-------

At the Compute level you will need two EC2 instances. Each instance should be designed to host the respective MapNotes and GeoServer APIs.

Storage
-------

- 

Limited Guidance
================

Review your notes and the walkthroughs (listed below) we completed as a class to guide your deployment.

- :ref:``

Turning in your work
====================

After completing your requirements and updating your Zika Client you can share the public:

- Zika Client bucket URL
- MapNotes API URL
- GeoServer API URL