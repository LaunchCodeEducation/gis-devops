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

This will allow us to create a new RDS on our VPC.

To interact with this VPC we will also be creating a new EC2 instance that will serve as a jumpbox.

Create RDS Networking Resources
===============================

We will be adding this RDS to the VPC of our project. For the purposes of this walkthrough it will be the VPC of your Todo Tasks API deployment.

Navigate to VPC
---------------

Navigate to the VPC dashboard by searching for the ``VPC`` service.

.. image:: /_static/images/aws-rds/15-services-vpc.png

Create Subnet
-------------

From the side bar menu on the left scroll down to and select ``Subnets`` which will show you a list of all the subnets associated with this region. We want to add a new subnet so click the orange ``Create subnet`` button:

.. image:: /_static/images/aws-rds/16-create-subnet.png

Select Correct VPC
------------------

The first section of the Create subnet form is the associated ``VPC``. Make sure to use the VPC for your project:

.. image:: /_static/images/aws-rds/17-subnet-vpc.png

Subnet Settings
---------------

After selecting the VPC to associate with your new subnet you can add both the subnets. For each subnet we will be setting:

- name
- availability zone
- CIDR block

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

Set it's inbound rules:

.. ::

    .. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-inbound-outbound-rules.png

.. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-inbound-rules.png

You will search for project name, but then will have to select both of them.

.. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-inbound-rules-final.png

Then set the outbound rules:

.. image:: /_static/images/aws-rds/21-create-private-postgres-db-sg-outbound-rules.png

Click the ``create`` button and then return to the Security Group dashboard, the easiest way is by clicking the breadcrumb link:

.. image:: /_static/images/aws-rds/23-sg-breadcrumb.png

PublicProjectNameAPI Security Group
-----------------------------------

Create a new Security Group to allow HTTP/S traffic to your Public Web API.

Set the name, description and VPC:

.. image:: /_static/images/aws-rds/24-create-public-api-sg-basic-details.png

Set the inbound rules:

.. image:: /_static/images/aws-rds/25-create-public-api-sg-inbound-rules.png

Set the outbound rules:

.. image:: /_static/images/aws-rds/26-create-public-api-sg-outbound-rules-search.png

.. image:: /_static/images/aws-rds/27-create-public-api-sg-outbound-rules-final.png

Click create. After creating this security group we need to edit the inbound rules of our previous security group using this new security group.

Edit PrivatePostgresDB SG
-------------------------

Click the breadcrumb back to Security Groups. You are looking for your PrivatePostgresDB (double check your VPC) and then click ``edit inbound rules``:

.. image:: /_static/images/aws-rds/28-private-postgres-edit-inbound-rules.png

Select the PublicProjectNameAPI security group you created in the previous step:

.. image:: /_static/images/aws-rds/29-private-postgres-edit-inbound-rules-source.png

.. image:: /_static/images/aws-rds/30-private-postgres-edit-inbound-rules-source-final.png

Click ``save`` to update the inbound rules.

Create SSH Group
----------------

Create the Security Group for SSH access:

Name, Description and VPC:

.. image:: /_static/images/aws-rds/31-create-ssh-sg.png

Inbound rules:

.. image:: /_static/images/aws-rds/32-create-ssh-sg-rules.png

Outbound rules:

.. image:: /_static/images/aws-rds/32-create-ssh-sg-outbound.png

Create JumpBox SG
-----------------

Add the final SG we will need for our jumpbox:

Name, description, VPC:

.. image:: /_static/images/aws-rds/41-basic-details.png

Inbound rules:

.. image:: /_static/images/aws-rds/42-inbound-rules.png

Outbound rules:

.. image:: /_static/images/aws-rds/43-outbound-rules.png

.. image:: /_static/images/aws-rds/44-outbound-rules-final.png

Create Subnet Group
===================

With our Subnets and Security Groups created, let's create a subnet group that will be used by our RDS.

.. todo:: the name should have dashes

Search for the ``RDS`` service:

.. image:: /_static/images/aws-rds/1-rds-search.png

From the ``RDS`` dashboard scroll the left hand menu bar down and select the ``Subnet groups`` option. From here click the orange ``Create DB Subnet Group`` button:

.. image:: /_static/images/aws-rds/33-create-db-subnet-group.png

This will take you to the ``Create DB Subnet Group`` web form.

Set the Name, Description, and VPC:

.. image:: /_static/images/aws-rds/34-subnet-group-details.png

Select the two availability zones you used for your security groups, and select your two subnets:

.. image:: /_static/images/aws-rds/35-add-subnets.png

.. admonition:: note

    1. select the AZs of your 2 private subnets (should be first and second choices)
    2. select the 2 subnets (make sure they are both private - should not be 10.0.0.0/24)

Create RDS
==========

Now that we have our database subnets, subnet group and have updated our security groups, let's create the RDS instance. Navigate to the RDS dashboard.

.. image:: /_static/images/aws-rds/2-rds-dashboard.png

From here click the ``create database`` button.

Creation Method
---------------

Select ``Standard create``:

.. image:: /_static/images/aws-rds/3-standard-create.png

Engine Options
^^^^^^^^^^^^^^

Select ``PostgreSQL`` Version ``PostgreSQL 12.4-R1``:

.. image:: /_static/images/aws-rds/4-engine-options.png

Templates
^^^^^^^^^

Select ``Free tier``:

.. image:: /_static/images/aws-rds/5-templates.png

Settings
^^^^^^^^

Set ``DB instance identifier``, ``Master username``, ``Master password`` and ``Confirm password``:

.. image:: /_static/images/aws-rds/6-settings.png

DB Instance Size
^^^^^^^^^^^^^^^^

Leave all the default settings for ``DB Instance Size``:

.. image:: /_static/images/aws-rds/6-2-db-instance-size.png

Storage
^^^^^^^

Leave all the default settings for ``Storage``:

.. image:: /_static/images/aws-rds/7-storage.png

Availability & Durability
^^^^^^^^^^^^^^^^^^^^^^^^^

Since we are using the free-tier we aren't even allowed to create a standby instance. It should be greyed out, so leave this section untouched:

.. image:: /_static/images/aws-rds/8-availability-durability.png

Connectivity
^^^^^^^^^^^^

Select your VPC for connectivity:

.. image:: /_static/images/aws-rds/9-connectivity.png

Click the dropdown arrow for ``Additional connectivity configuration``.

Set the ``Subnet group`` (using the one we created earlier):

.. image:: /_static/images/aws-rds/10-connectivity-additional-1.png

Set the ``Existing VPC security groups`` (using PrivatePostgresDB):

.. image:: /_static/images/aws-rds/11-connectivity-additional-2.png

.. todo:: check if RDS needs 2 public and 2 private subnets

Database Authentication
^^^^^^^^^^^^^^^^^^^^^^^

Leave the ``Database authentication`` section at the default value ``Password authentication``:

.. image:: /_static/images/aws-rds/12-database-authentication.png

Additional Configuration
^^^^^^^^^^^^^^^^^^^^^^^^

Click the ``Additional configuration`` drop down arrow.

Set ``Initial database name`` (make sure to use the database name your project uses):

.. image:: /_static/images/aws-rds/13-additional-configuration-1.png

De-select any selected options under ``Backup``, ``Performance Insights``, ``Monitoring``, and ``Log exports``:

.. image:: /_static/images/aws-rds/13-additional-configuration-2.png

.. admonition:: note

    AWS RDS will automatically create backups, perform performance insights, monitor the RDS service. For the purposes of this class we will not be exploring any of these concepts, so we are turning them off. In a real world database you would configure each of these things as they provide redundancy and information for troubleshooting.

For the remainder of the form it should be all defaults, confirm yours with:

.. image:: /_static/images/aws-rds/13-additional-configuration-3.png

We have completed all the information necessary to create our RDS instance so click ``Create RDS``.

Create Error
^^^^^^^^^^^^

If you get the following error:

.. image:: /_static/images/aws-rds/15-subnet-warning.png

You did not create your ``DB Subnet Group`` before creating your RDS instance.

View RDS Instance
=================

You will need to view your RDS instance, we will need the RDS endpoint after it is done initializing.

.. image:: /_static/images/aws-rds/14-rds-instance-link.png

Create EC2 Jumpbox
==================

While we are waiting for our RDS instance to spin up let's create the Jumpbox we will be using to interface with our RDS instance.

Our RDS instance is on a private subnet, which means it's only accessible to internal VPC network. We can't simply PSQL into the RDS from our local computer. We will first need to create an intermediary jumpbox. This EC2 will have one responsibility: ``provide administrative access to the private RDS``.

Create EC2 Instance
-------------------

Search for the ``EC2`` service, and then click the ``create`` button.

From here we will be spinning up a new Ubuntu EC2 instance with the following information:

- AMI: ubuntu 18.04
- type: micro
- VPC & subnet: your vpc public subnet
- User data script: enter a first time setup script

Following are the images that will guide your process:

``Network``, ``Subnet``, ``Auto-assign Public IP``:

.. image:: /_static/images/aws-rds/36-jumpbox-config.png

At the very bottom of the form is the ``Advanced Details`` drop down arrow. Click it and paste in the following script to the ``User data`` section.

.. sourcecode:: bash

    #!/bin/bash
    apt update -y
    apt upgrade -y
    apt install -y postgresql-client

.. admonition:: note

    The image isn't correct, but does illustrate where to add the following script.

.. image:: /_static/images/aws-rds/37-jumpbox-user-data-script.png

Add tags to make your EC2 distinguishable from others:

.. image:: /_static/images/aws-rds/38-jumpbox-name-tag.png

On the next page of ``Security Groups`` choose the Jumpbox Security Group we created above.

As a reminder it allows inbound traffic on port 22 to your computer. It allows outbound traffic on ports 80, 443, and 5432.

.. ::

    .. image:: /_static/images/aws-rds/39-jumpbox-ssh-sg.png

Finally set the key pair for the jumpbox. It's easiest to use the key you already created in this class:

.. image:: /_static/images/aws-rds/40-jumpbox-pem.png

.. admonition:: note
    
    As a best practice you would typically have a different key-pair for this jumpbox than from the key for your Web API EC2, however you are not required to do that in this class.

Connect to RDS
==============

Now that we have created our RDS jumpbox, check back on your RDS instance. It probably has an RDS endpoint we can use to connect to the database. We will need that RDS endpoint in order to access the RDS from our jumpbox.

SSH into the jumpbox.

From here use psql client to connect to RDS.

.. sourcecode:: bash

    psql -h rds-poc-db.cq2s2klvmrfq.us-west-2.rds.amazonaws.com -U launchcode -d project_name

You should use your RDS public endpoint, and your database name.

Configure RDS
-------------

Once you are in the psql CLI for your RDS enter the following commands to enable PostGIS:

.. sourcecode:: sql

    create extension postgis;
    create extension fuzzystrmatch;
    create extension postgis_tiger_geocoder;
    create extension postgis_topology;

    create user project_name_user with encrypted password 'password';
    grant all privileges on database project_name to project_name_user;

.. admonition:: note

    While enabling PostGIS isn't necessary for the Todo Tasks API RDS isntance, it will be necessary for your MapNotes RDS instance. You will need to create the application database user, password and grant them privileges.

Update Systemd Service Configuration File
=========================================

Now that our Database is setup properly we need to update our deployed API to use this new RDS instance.

SSH into the EC2 of your deployed API.

From here we will need to update the Systemd configuration file. It is currently using ``DB_HOST=localhost`` we need to update it to ``DB_HOST=your-rds-endpoint``. This file lives in ``/etc/opt/project-name`` and more than likely is named: ``project-name-app.config``.

After updating your configuration file you will need to stop and start the project service: ``sudo systemctl restart project-name.service``.

After restarting the service check the journalctl logs to make sure it connected to the database properly: ``journalctl -fu project-name.service``.

If your application doesn't start cleanly let your instructor know. It is almost certainly due to a misconfiguration with your RDS instance setup and you will need to troubleshoot it together.

Bonus: Clean up EC2
-------------------

Now that we are using RDS for our relational database needs we can remove some unecessary dependencies from the EC2 hosting our web application. It no longer needs ``docker``, ``docker-compose``, or the existing docker container.

Review
======

We migrated our embedded database as a docker container to AWS managed RDS.

To do this we:

- create new subnets
- create a new subnet group
- create RDS instance
- create an EC2 RDS jumpbox
- SSH into the RDS jumpbox
- Connect to RDS from jumpbox
- Configure RDS
- update security group rules
- update deployed API

.. ::

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


