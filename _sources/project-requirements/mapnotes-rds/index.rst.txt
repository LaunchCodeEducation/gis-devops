.. _project_deploy-mapnotes-rds:

====================================
Project: Map Notes Backed by AWS RDS
====================================

Map Notes API
=============

You currently have a deployed Map Notes API that is backed by an embedded PostGis docker container. This worked well for an example deployment as it allowed us to focus on just the basics for deploying a RESTful API built with Spring boot.

However, this presents a few issues:

- if our EC2 is destroyed we lose our data
- the database is hosted internally on an EC2 (we would need to do some un-intuitive networking to share access to the DB inside the EC2)
- our EC2 has too many responsibilities (hosting our deployed API and hosting the backing service)

As a best practice in deployments the backing services should be separated from any resources that need them. In addition backing services should have their data replicated across multiple availability zones.

Luckily for us we can achieve both best practices by utilizing the AWS Relational Database Service (RDS).

RDS
===

RDS is the preferred way of provisioning and managing Relational Databases with AWS. 

We configure the type of RDS we want, like Postgres version 12, provide the subnets and subnet group used by RDS and then AWS takes care of the rest. 

AWS will setup our database on servers across the provided subnets, making multiple copies to protect the integrity of our data. It will also spin up additional servers to handle database requests if the demand of our data increases.

Major benefits of RDS:

- data redundancy
- high availability
- easily scalable

Primary Objective
=================

Refactor your production environment so that your Map Notes API is supported by a database managed by AWS RDS.

Requirements
------------

Your Map Notes VPC must have:

- 1 public subnet
- 2 private subnets
- 1 subnet group for your RDS
- 1 private RDS instance
- 1 public EC2 that is used to host your Map Notes API
- 1 public EC2 that is used for interfacing with RDS

Your RDS instance must be:

- Engine type: PostgreSQL
- Version: ``PostgreSQL 12.4-R1``
- Templates: ``Free tier``
- Burstable classes: ``db.t2.micro``
- Allocated Storage: ``20 GiB``

Limited Guidance
----------------

Review your notes and the :ref:`aws-rds-walkthrough` for a reminder on how to create an RDS.

In no particular order:

- create 2 private subnets
- create subnet group
- create RDS instance
- create or alter Security Groups
- create EC2 RDS jumpbox
- configure RDS through jumpbox
- update EC2 Map Notes API to use RDS endpoint (service .config file)

Bonus Objectives
================

- clean up your EC2 Map Notes API so that it only contains resources necessary for hosting the Map Notes API
- alter your API SG so that SSH access is only allowed from private network
- talk to your instructor about hosting Geoserver on your VPC

Turning in your work
====================

After refactoring your network to utilize RDS send the IP address of your deployed application and the RDS endpoint to your instructor.