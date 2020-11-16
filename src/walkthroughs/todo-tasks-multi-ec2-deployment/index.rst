:orphan:

.. _todo-tasks-deployment-multi-ec2:

===================================
Todo Tasks Deployment Multiple EC2s
===================================

This Walkthrough assumes you have completed:

- :ref:`todo-tasks-deployment-single-ec2`
- :ref:`unit-files`
- :ref:`nginx-proxy-spring`

The previous three walkthroughs deploy the Todo Tasks API to a single EC2. The application is converted to a Systemd service, and uses NGINX to proxy HTTP requests from port 80 to the API port of 8080.

We will be editing this deployment by moving the database to it's own EC2 instance.

.. admonition:: hint

    In operations it is a best practice to separate the various services of an application into discrete cloud resources. For our Todo Tasks API this would be placing the Todo Tasks API into a public facing EC2 instance and the Postgres DB on a private EC2 instance.

    For our Zika project it would be placing the Mapnotes API on it's own public facing EC2 instance, Geoserver on it's own public facing EC2 instance, and the databases on their own private EC2 instances.

For this Todo Tasks multi EC2 Deployment we will need to:

- add a private subnet to our VPC
- create and configure EC2 on private subnet
- create ``docker-compose.yml`` on private EC2
- setup database on private EC2
- update Systemd service configuration file to point to the database

..

    .. image:: /_static/images/todo-tasks-multi-ec2-deployment/.png
        :alt: aws search

Add Private Subnet to our VPC
=============================

Our first step is to access our VPC.

Navigate to the VPC home screen:

.. image:: /_static/images/todo-tasks-multi-ec2-deployment/vpc-home.png
    :alt: aws search

From here search for your VPC from yesterday if you followed our naming pattern you can search for your own name:

.. image:: /_static/images/todo-tasks-multi-ec2-deployment/vpc-search.png
    :alt: aws search

After confirming your VPC still exists we will be creating and adding a new subnet to this VPC.

Select the Subnets option from the side-menu on the left:

.. image:: /_static/images/todo-tasks-multi-ec2-deployment/subnet-option.png
    :alt: 

This will take you to the subnet home page:

.. image:: /_static/images/todo-tasks-multi-ec2-deployment/subnet-home.png
    :alt: 

From the subnet home page click the ``Create subnet`` button in the top right corner. This will take you to the Create Subnet form.

.. image:: /_static/images/todo-tasks-multi-ec2-deployment/create-subnet-form.png
    :alt: 

On this form you will need to:

- select your Todo Tasks VPC: ``<your-name>-todo-tasks-api-vpc``
- set a subnet name: ``<your-name>-todo-tasks-private-subnet``
- set the availability zone: ``us-east-1a`` (it's the first option)
- set the IPv4 CIDR block: ``10.0.1.0/24``
- set a tag key and value: ``<your-name>-todo-tasks-private-subnet``

Then click ``Create subnet``. It should only take a matter of seconds to create your subnet. You can view it by searching for your VPC in the subnets section.

.. image:: /_static/images/todo-tasks-multi-ec2-deployment/vpc-subnets.png
    :alt: 


Now our VPC has two subnets. A public subnet bound to the CIDR block: ``10.0.0.0/24`` and a private subnet bound to the CIDR block: ``10.0.1.0/24``.

.. admonition:: note

    A CIDR block is notation representing a collection of IP addresses.

    The CIDR block ``10.0.0.0/24`` refers to the range of IP addresses between ``10.0.0.0`` and ``10.0.0.255``. This is roughly 250 IP addresses that must start with ``10.0.0``.

    The CIDR block ``10.0.0.0/16`` refers to the range of IP addresses between ``10.0.0.0`` and ``10.0.255.255``. This is roughly 65000 IP addresses that must start with ``10.0``.

    The CIDR block ``10.0.0.0/8`` refers to the range of IP addresses between ``10.0.0.0`` and ``10.255.255.255``. This is roughly 16 million IP addresses that must start with ``10``.

So this VPC has a public subnet with addresses bound between: ``10.0.0.0`` to ``10.0.0.255`` and a private subnet with addresses bound between: ``10.0.1.0`` to ``10.0.1.255``.

Create an EC2 on the Private Subnet
===================================

Access the EC2 on the Private Subnet
====================================

- we need a jump box!

Create the ``docker-compose.yml`` File
======================================

Create the Database
===================

Update the public EC2 Environment Variables
===========================================




Review
======

