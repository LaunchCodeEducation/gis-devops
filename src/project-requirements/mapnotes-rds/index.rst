.. _project_deploy-mapnotes-rds:

====================================
Project: Map Notes Backed by AWS RDS
====================================

Map Notes API
=============

You currently have a deployed Map Notes API that is backed by an embedded PostGis docker container. This worked well for an example deployment as it allowed us to focus on just the basics for deploying a RESTful API built with Spring boot.

However, this presents a few issues:

- if our EC2 is destroyed we lose our data
- the database is hosted internally on an EC2 (we would need to allow networking to the EC2 with the database if we spin up new EC2s)
- our EC2 has too many responsibilities (hosting our deployed API and hosting the backing service)

As a best practice in deployments the backing services should be separated from any resources that need them. In addition backing services should have their data replicated across multiple regions.

Luckily for us we can achieve both best practices by utilizing the AWS Relational Database Service (RDS).

RDS
===

RDS is the preferred way of provisioning and managing Relational Databases with AWS. RDS is an AWS managed resource. We will configure the type of RDS we want, like Postgres version 12, and provide the subnets of the VPC the RDS will inhabit then AWS takes care of the rest. It will setup our database on servers across the provided subnets, making multiple copies to protect the integrity of our data. It will also spin up additional servers to handle database requests if the demand of our data increases.



Requirements
============

- Map Notes API must use a local docker container as a backing service
- Map Notes API EC2 must only be accessible via port 80
- Map Notes API EC2 must use NGINX to proxy traffic from port 80 to the running application
- Map Notes API must run as a systemd service

Limited Guidance
================

Review your notes and the walkthroughs (listed below) we completed as a class to guide your deployment.

- :ref:`todo-tasks-deployment-single-ec2`
- :ref:`unit-files`
- :ref:`nginx-proxy-spring`

As a reminder this deployment will require work in the following categories:

- Build artifacts
- Deliver artifacts
- Create AWS Infrastructure
- Configure AWS Infrastructure

Turning in your work
====================

After deploying the Map Notes API to an AWS EC2 share the public IP address with your instructors.