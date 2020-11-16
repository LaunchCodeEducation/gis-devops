:orphan:

.. _watch-todo-tasks-deployment:

=============================
Watch a Todo Tasks Deployment
=============================

Watch as your instructor takes you through a deployment of the Todo Tasks API. This is something you will be doing tomorrow.

You can find the source code to the `todo-tasks-api solution on gitlab <https://gitlab.com/LaunchCodeTraining/todo-tasks-api-solution>`_.

Our goal is to take this completed API and to deploy it, making it accessible to anyone via the internet.

Recall from our lecture the major deployment categories:

- Build artifacts
- Deliver artifacts
- Create server
- Configure server

Each of these categories may have multiple sub steps.

Build Artifacts
===============

When building artifacts the goal is to create a small number of files (like one executable) that can be run by any machine that has the appropriate run time environment. In the case of purely front end application, like the Zika Client, the browser is the run time environment and contains all of the necessary tools to render, and run HTML, CSS, and JavaScript.

In the case of Java we will need to generate a JAR (Java Archival) file. This is the file that can be executed by any machine that has the appropriate Java run time environment (JRE).

We have been using Gradle as our dependency management and build tool. By using the gradle ``bootJar`` task a JAR file will be created for us.

Deliver Artifacts
=================

We will need to move this JAR file that was just created to a location that our server can access. In this case we will be moving it to S3, Amazon's Simple Storage Service. Our Virtual Machine will be granted access to the files in this S3 bucket.

We will need to:

- create a suitable bucket
- copy our JAR file to the bucket

Consider the database dependency of our Java project. Currently in our local environment we are using a Docker container that holds a Postgres image that stores the data of our API. We will need to recreate this container on our server so that our API can access a database.

For this reason we will also need to move our ``docker-compose.yml`` file to the S3 bucket as well.

Create Server
=============

Our next step is to create our server. However, a server cannot live in isolation. It must be attached to a Virtual Network so internet access can be granted to the server.

Before we can create our server, we will need to create a Virtual Network.

Create a Virtual Network
------------------------

We will discuss virtual networks in greater detail when we have more AWS resources, for now a simple network with one public subnet will suffice.

Your instructor will name the virtual network, and ensure it has a public subnet.

Create a Virtual Machine
------------------------

Now that we have a publicly accessible network we can add a Virtual Machine.

Configuring the Virtual Machine can take a lot of work. Since the Virtual Machine is a full fledged computer in the cloud we need to provide complete information in order to create the machine including:

- Operating System image
- CPU
- RAM
- Hard Disk Storage
- Firewall network rules
- S3 access

After setting everything up the server will start spinning up. It is normal for this to take a few minutes.

Configure Server
================

After the server is fully provisioned we need to interface with it in order to install the remaining dependencies. The Virtual Machine is just a computer in the cloud, and it will need all the dependencies we have on our local laptop necessary to run the project.

This is quite a few things:

- Docker engine
- Docker compose
- Java 11 run time
- AWS CLI

After installing the necessary software via the OS package manager we will need to get the build artifacts.

Using the AWS CLI we will need to get the ``app.jar`` and ``docker-compose.yml`` files we delivered earlier.

After getting these files we will need to setup our database. Luckily this is quite easy with the ``docker-compose up -d`` command.

Finally we will need to engage the Java run time with our application environment variables in order to run our app.

After our app is up and running we will be able to access it via the internet!