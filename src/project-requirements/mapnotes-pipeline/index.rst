.. _project_mapnotes-pipeline:

======================================
Project: Mapnotes API Jenkins Pipeline
======================================

Map Notes API
=============

For this project you will be setting up a Jenkins pipeline for your Mapnotes API.

Requirements
============

- Create a CI/CD pipeline for your Map Notes API
- Add tests
- Redeploy the Map Notes API with the build artifacts created from Jenkins

Map Notes API CI/CD Pipeline
============================

For this first requirement you will need to create Jenkins projects for each part of step necessary to deliver your Map Notes artifacts to your S3 bucket.

You are more than welcome to use the Jenkins container you set up in the Todo Tasks Jenkins walkthrough. This will save you configuration time.

You are required to create **at least** the following tasks as a part of your CI/CD pipeline:

- Compile your Java source code
- Run all the tests in your source code
- Build a jar file
- Deliver the jar file

In addition to these specific Jenkins projects you need to setup your Jenkins pipeline to automatically fire when it detects changes on your master branch. Using ``Poll SCM`` meets the requirement.

Add Tests
=========

To put your new pipeline to good use we will need to make some changes to our source code.

After deploying our Zika Clients to use our Map Notes API we started getting CORS errors. We talked about the cause of these errors and how to eliminate the error.

This is a great opportunity for us to add to our integration tests to increase our test coverage.

For this requirement you need to add to your integration tests, they should check the headers of the HTTP response for the proper header.

In the case of our Java API's and the MockMVC library we would expect the ``Vary`` Header with a value of ``Origin``.

Redeploy Map Notes API
======================

After you have made the changes to your source code by adding new tests, and the code necessary to pass those tests you need to do a new deployment.

Luckily you have a Jenkins pipeline so building and delivering artifacts should be done for you.

SSH into your EC2 instance and re-deploy the Map Notes API with the updated source code.

Bonus
=====

Add additional tests that verify valid JSON is being sent back when GET requests are made to ``/notes/{id}/tasks``.

Deploy Jenkins to an EC2 and integrate it with GitLab so that when source code is pushed or merged into the master branch a new build is automatically triggered.