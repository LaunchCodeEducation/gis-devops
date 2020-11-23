:orphan:

.. _aws-rds-walkthrough:

================
Walkthrough: RDS
================

In this walkthrough we will be moving our PostGIS database from the EC2 that hosts our web application to a dedicated Amazon managed RDS.

We will be editing our VPC in the following ways:

- creating two new private subnets
- create a new subnet group from the two new private subnets
- editing our security groups

This will allow us to create a new RDS for our database.

You can only create an RDS when you have a VPC with at least a public subnet

Create RDS Networking Resources
===============================

We will be adding this RDS to the VPC of our project. For the purposes of this walkthrough it will be the VPC of your Todo Tasks API deployment.

Navigate to VPC
---------------

.. image:: /_static/images/aws-rds/15-services-vpc.png

Create Subnet
-------------

.. image:: /_static/images/aws-rds/16-create-subnet.png

Select Correct VPC
------------------

.. image:: /_static/images/aws-rds/17-subnet-vpc.png

Subnet Settings
---------------

Set-up the first subnet:

.. image:: /_static/images/aws-rds/18-subnet-settings-first-subnet.png

Click ``add subnet`` and then set up the second subnet:

.. image:: /_static/images/aws-rds/19-subnet-settings-second-subnet.png

Click the ``create`` button.

Create Security Groups
======================

Now that our deployment is changing we need to update our existing security groups. We will be deleting the existing security groups associated with your VPC and we will be creating three new ones:

.. in notes patrick sent earlier

- public Web API SG (inbound HTTP/S, outbound HTTP/S + postgres 5432)
- create PrivatePostgresDB SG (inbound 5432, outbound HTTP/S)
- create <Name>SSH SG (inbound SSH for <name> IP)

In VPC dashboard scroll down the left hand menu to security groups:

.. image:: /_static/images/aws-rds/22-scroll-to-security-groups.png

PrivatePostgresDB
-----------------

Create a new Security Group to allow postgres traffic to your Public Web API:

.. image:: /_static/images/aws-rds/20-create-private-postgres-db-sg-basic-details.png

Set it's inbound and outbound rules:

.. ::

    .. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-inbound-outbound-rules.png

.. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-inbound-rules.png

You will search for project name, but then will have to select both of them.

.. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-inbound-rules-final.png

.. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-outbound-rules.png

after creating click breadcrumb link to go back to create SG page

.. image:: /_static/images/aws-rds/23-sg-breadcrumb.png

PublicProjectNameAPI Security Group
-----------------------------------

Create a new Security Group to allow HTTP/S traffic to your Public Web API:

.. image:: /_static/images/aws-rds/24-create-public-api-sg-basic-details.png

Set the inbound and outbound rules:

.. image:: /_static/images/aws-rds/25-create-public-api-sg-inbound-rules.png

.. image:: /_static/images/aws-rds/26-create-public-api-sg-outbound-rules-search.png

.. image:: /_static/images/aws-rds/27-create-public-api-sg-outbound-rules-final.png

Click the breadcrumb back to Security Groups. You are looking for your PrivatePostgresDB (double check your VPC) and then click ``edit inbound rules``:

.. image:: /_static/images/aws-rds/28-private-postgres-edit-inbound-rules.png

Select the PublicProjectNameAPI security group you created in the previous step:

.. image:: /_static/images/aws-rds/29-private-postgres-edit-inbound-rules-source.png

.. image:: /_static/images/aws-rds/30-private-postgres-edit-inbound-rules-source-final.png

Click ``save`` to update the inbound rules.

Create SSH Group
----------------

One final Security Group for SSH access:

.. image:: /_static/images/aws-rds/31-create-ssh-sg.png

.. image:: /_static/images/aws-rds/32-create-ssh-sg-rules.png

.. image:: /_static/images/aws-rds/32-create-ssh-sg-outbound.png

go to RDS

Create JumpBox SG
-----------------

.. image:: /_static/images/aws-rds/41-basic-details.png

.. image:: /_static/images/aws-rds/42-inbound-rules.png

.. image:: /_static/images/aws-rds/43-outbound-rules.png

.. image:: /_static/images/aws-rds/44-outbound-rules-final.png

Create Subnet Group
===================

.. todo:: the name should have dashes

.. image:: /_static/images/aws-rds/1-rds-search.png

.. image:: /_static/images/aws-rds/33-create-db-subnet-group.png

.. image:: /_static/images/aws-rds/34-subnet-group-details.png

Select the two availability zones you used for your security groups

.. image:: /_static/images/aws-rds/35-add-subnets.png

.. admonition:: note

    1. select the AZs of your 2 private subnets (should be first and second choices)
    2. select the 2 subnets (make sure they are both private - should not be 10.0.0.0/24)

After saving go back to the Side-bar dashboard.

Navigate to RDS
===============

.. image:: /_static/images/aws-rds/2-rds-dashboard.png

Creation Method
===============

.. image:: /_static/images/aws-rds/3-standard-create.png

Engine Options
--------------

.. image:: /_static/images/aws-rds/4-engine-options.png

Templates
---------

.. image:: /_static/images/aws-rds/5-templates.png

Settings
--------

.. image:: /_static/images/aws-rds/6-settings.png

DB Instance Size
----------------

Storage
-------

.. image:: /_static/images/aws-rds/7-storage.png

Availability & Durability
-------------------------

.. image:: /_static/images/aws-rds/8-availability-durability.png

Connectivity
------------

.. image:: /_static/images/aws-rds/9-connectivity.png

.. image:: /_static/images/aws-rds/10-connectivity-additional-1.png

.. image:: /_static/images/aws-rds/11-connectivity-additional-2.png

.. todo:: check if RDS needs 2 public and 2 private subnets

Database Authentication
-----------------------

.. image:: /_static/images/aws-rds/12-database-authentication.png

Additional Configuration
------------------------

.. image:: /_static/images/aws-rds/13-additional-configuration-1.png

.. image:: /_static/images/aws-rds/13-additional-configuration-2.png

.. image:: /_static/images/aws-rds/13-additional-configuration-3.png

Create
------

.. image:: /_static/images/aws-rds/15-subnet-warning.png


View RDS Instance
=================

.. image:: /_static/images/aws-rds/14-rds-instance-link.png

Create EC2 Jumpbox
==================

Spin up an Ubuntu EC2 on 

- ubuntu 18.04
- micro
- your vpc public subnet
- enter the following intialization script

.. image:: /_static/images/aws-rds/36-jumpbox-config.png

.. image:: /_static/images/aws-rds/37-jumpbox-user-data-script.png

.. sourcecode:: bash

    #!/bin/bash
    apt update -y
    apt upgrade -y
    apt install -y postgresql-client

.. image:: /_static/images/aws-rds/38-jumpbox-name-tag.png

.. image:: /_static/images/aws-rds/39-jumpbox-ssh-sg.png

.. image:: /_static/images/aws-rds/40-jumpbox-pem.png

Connect to RDS
==============

SSH into the jumpbox.

From here use psql client to connect to RDS.

.. sourcecode:: bash

    psql -h rds-poc-db.cq2s2klvmrfq.us-west-2.rds.amazonaws.com -U launchcode -d project_name

You should use your RDS public endpoint, and your database name.

Configure RDS
-------------

Once you are in the psql CLI for your RDS enter the following commands:

.. sourcecode:: sql

    create extension postgis;
    create extension fuzzystrmatch;
    create extension postgis_tiger_geocoder;
    create extension postgis_topology;

    create user project_name_user with encrypted password 'password';
    grant all privileges on database project_name to project_name_user;

Update Systemd Service Configuration File
=========================================

Update your config file so that it points at your RDS endpoint. Stop and start the service.






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


