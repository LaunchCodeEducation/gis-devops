.. _project_deploy-mapnotes-api-single-ec2:

=========================================
Project: Deploy Map Notes to a Single EC2
=========================================

Map Notes API
=============

For this project you will be deploying the Map Notes API to an AWS EC2 instance.

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