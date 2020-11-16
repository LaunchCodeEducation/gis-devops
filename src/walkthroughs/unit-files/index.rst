:orphan:

.. _unit-files:

=============================================
Running a Java Application as a Linux Service 
=============================================

This walkthrough assumes you have deployed an API built with Java/Spring to a Virtual Machine. 

If you need a refresher check out the :ref:`todo-tasks-deployment-single-ec2` walkthrough.

That walkthrough ended with us running the application by manually issuing a bash command: ``sudo java -jar todo-app.jar --DB_HOST=localhost --DB_PORT=5444 --DB_NAME=todo --DB_USER=todo_user --DB_PASS=todopass --APP_PORT=80``.

While this worked for us in this educational environment, it is not a reliable solution for running our application. In the case of the server crashing, the EC2 instance going down, or experiencing a power outage the application would need to be manually started with the command used above.

There is an elegant solution for this in Linux. We can configure and run this Java application as a Linux SystemD service.

SystemD
=======

SystemD is initialization software on most Linux distributions.

It gives us, the developers, a way of defining how an application can be run and managed by the Linux Operating System. When an application is ran, and managed by SystemD it is referred to as a SystemD ``service``.

As the developers we can define whatever services we want. It is essentially instructions attached to an executable or an application.

To define a new service we will create a ``unit`` file that defines the executable and additional instructions.

Define Service with a Unit File
===============================

As a best practice we will be storing all of our Unit files in one place on our linux machines: ``/etc/systemd/system/``.

As an additional best practice we will name the unit file after the service we are creating. In this case the service is our Todo App. So we will create a new file named: ``todo-app.service``.

Create the file and add the following code:

.. sourcecode:: bash
    :caption: Unit File ``/etc/systemd/system/todo-app.service``
    
    [Unit]
    Description=Todo Tasks API
    After=syslog.target

    [Service]
    Type=simple
    User=ubuntu
    EnvironmentFile=/etc/opt/todo-app/todo-app.config
    ExecStart=/usr/bin/java -jar /home/ubuntu/todo-app.jar SuccessExitStatus=143
    Restart=always

    [Install]
    WantedBy=multi-user.target

Let's break down the configuration of this unit file:

.. sourcecode:: bash
    :caption: Commented Unit File
    
    # Unit Section
    [Unit]
    # Human Readable Description of the Service
    Description=Todo Tasks API
    # After=list of units that must be started before this unit works
    After=syslog.target

    # Service Section
    [Service]
    # simple is the default value of Type, it is commonly left off
    Type=simple
    # User= sets the user, login shell, and home directory associated with this unit
    User=ubuntu
    # EnvironmentFile= points to the environment variables needed by the executable in this unit file
    EnvironmentFile=/home/ubuntu/todo-app.config
    # ExecStart= the exact command, or application to be run when this unit starts
    ExecStart=/usr/bin/java -jar /home/ubuntu/todo-app.jar SuccessExitStatus=143
    # Restart= if the unit should restart after failing
    Restart=always

    # Install Section
    [Install]
    # WantedBy=multi-user.target is the command neccessary so this systemd unit can be enabled (which is what allows it to automatically start when the server boots up)
    WantedBy=multi-user.target

We can now start our application with ``sudo systemctl start todo-app.service``!

Service Environment File
------------------------

Before we get to enabling and starting our new service we need to define the environment variables that are needed by our ``todo-app.service``.

As a best practice we will be storing the environment variables for this service in: ``/etc/opt/todo-app/todo-app.config``.

We will need to create the ``todo-app/`` directory inside of the ``/etc/opt/`` directory:

.. sourcecode:: bash

    sudo mkdir /etc/opt/todo-app

We will then need to create and edit the environment variables with:

.. sourcecode:: bash

    sudo vim /etc/opt/todo-app/todo-app.config

Within vim change into insert mode by hitting ``i`` and paste in our environment variables:

.. sourcecode:: bash

    DB_HOST=localhost
    DB_PORT=5444
    DB_NAME=todo
    DB_USER=todo_user
    DB_PASS=todopass
    APP_PORT=8080

After pasting in these environment variables save and quit the file by hitting ``esc`` in vim and then entering ``:wq`` and hitting ``enter``.

This will be the environment variables that are passed to the ``ExecStart`` directive in our Unit File. Note that these environment variables match up with the ``application.properties`` file of our Todo Tasks API. We are at runtime injecting a series of environment variables that are unique to this application environment.

As we progress through multiple deployments we will change some of these in the environment file to reflect the location and port of our database.

Enabling and Starting our Service
=================================

Now that we have defined our service with the unit file, and have created it's necessary config file we can enable and start our service.

Enable Service
--------------

From the terminal of the EC2 enable the service to be managed by Linux:

.. sourcecode:: bash

    sudo systemctl enable todo-app.service

Enabling the service is what tells our EC2 instance to automatically start this service when the machine first boots up. This will ensure that if the server restarts for any reason it will automatically restart our API!

Start Service
-------------

Although we enabled our service above, it will only start if the EC2 reboots. Instead of doing that, let's simply start the service ourselves:

.. sourcecode:: bash

    sudo systemctl start todo-app.service

And our service should attempt to start and is being managed by SystemD.

Troubleshooting our Service
===========================

The first few times you are defining a new service you will undoubtedly make mistakes, or in some cases the application may encounter a bug and print out information to the Tomcat logs.

We can view these logs by accessing the journal of this service:

.. sourcecode:: bash

    journalctl -fu todo-app.service

``journalctl`` options:

- ``-u``: the unit file we are accessing
- ``-f``: print out the last 10 lines of the journal, update as new logs come in

Reading these logs are invaluable for determining why a service cannot start. Common issues with Java Spring APIs:

- incorrect port
- incorrect DB information
- no environment variables

Service Best Practices
======================

- unit files live in: ``/etc/systemd/system/``
- config files live in: ``/etc/opt/<app-name>/<app-name>/config``
- executables of services live in: ``/opt/<app-name>/<app-name-artifacts>``
- service should be owned by non root singular user
- service should only be accessible by non root singular user

We are already following the first two best practices. However, we need to make some changes in order to achieve the remaining three best practices.

Move Executable
---------------

Create Executable Directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^

We will need to create a new directory and move our JAR file into this new appropriate directory.

.. sourcecode:: bash

    sudo mkdir /opt/todo-app

Move Executable
^^^^^^^^^^^^^^^

Now we need to move our JAR file into this location:

.. sourcecode:: bash

    sudo mv /home/ubuntu/todo-app.jar /opt/todo-app

.. admonition:: note

    Now would be a good time to update our Service unit file, but we are about to make another change that will facilitate even more changes to the unit file, so let's make those changes first and update our unit file in one pass.

Service Owner
-------------

One service should be owned by a non root user.

Create User
^^^^^^^^^^^

.. sourcecode:: bash

    useradd -M todo

Update File System Permissions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. sourcecode:: bash

    chown -R todo:todo /opt/todo-app /etc/opt/todo-app

Update Unit File
----------------

We need to reflect the changes made to the user, and the new JAR location in our unit file:

.. sourcecode:: bash

    [Unit]
    Description=Todo Tasks API
    After=syslog.target

    [Service]
    Type=simple
    User=todo # this line changes to reflect the new todo user
    EnvironmentFile=/etc/opt/todo-app/todo-app.config
    ExecStart=/usr/bin/java -jar /opt/todo-app/todo-app.jar SuccessExitStatus=143 # this line changes to reflect the new location of the JAR file
    Restart=always

    [Install]
    WantedBy=multi-user.target

Reload Service
^^^^^^^^^^^^^^

Since our Service unit file has been changed we need to do a few steps to update it:

.. sourcecode:: bash

    sudo systemctl stop todo-app.service
    sudo systemctl disable todo-app.service
    sudo systemctl daemon-reload
    sudo systemctl enable todo-app.service
    sudo systemctl start todo-app.service

Now that we have updated our Service unit file to follow the best practices check that the application started up correctly by viewing it's ``journalctl``.

Review
======

This walkthrough converted our Todo Tasks API into a SystemD service. 

The service is now manageable by Linux through the use of ``systemctl``. In addition, the service is configured to start automatically on server startup, and to attempt to restart if the application crashes for any reason.

You may have noticed that we changed the port of this application to ``8080`` from what we used in the previous walkthrough using ``80``. You may have a Security Group that is configured to allow traffic on port 80, but not port 8080. 

You could update this yourself, or hang tight for the next walkthrough where we will see how to use :ref:`nginx-proxy-spring` between port 80, and our running application on port 8080.