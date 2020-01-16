:orphan:

.. _docker-jenkins:

============================
Installation: Docker Jenkins
============================

Installation Steps
------------------

#. Download and run a new Jenkins container
#. Jenkins First Time Setup
#. Additional Information

Download and Run Jenkins Container
----------------------------------

Docker makes creating new containers really easily, we simply need to provide a name for our container, open the correct ports, and include the image we want to run in our container.

``docker run --name jenkins -p 7070:8080 -dt launchcodedevops/jenkins-awscli`` or if you need to provide your AWS Credentials:

``docker run --name jenkins -p 7070:8080 -e AWS_ACCESS_KEY_ID=your_aws_access_key -e AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key -dt launchcodedevops/jenkins-awscli``

If you have AWS Credentials you can view them on your AWS Console under IAM. You may also have configured your local machine to work with the AWS CLI. If so you can find your AWS credentials with ``cat ~/.aws/credentials``.

You've probably seen many docker run commands already throughout this class this command in a similar vein to the other commands creates a new container from an image. This container however opens port 7070 on the container, and then forwards it to port 8080 -- the default port Jenkins is running on.

After running this command, use ``docker ps`` to make sure the container is up and running, and then navigate to localhost:7070 in your browser. You should see the Jenkins first time unlock page.

.. tip::

   Try changing the -p 7070:8080 to another port like -p 9090:8080 to see how this affects our access to the container.

Jenkins First Time Setup
------------------------

We will need to unlock Jenkins so that we can use it the file with this information is usually at ``/var/jenkins_home/secrets/initialAdminPassword``. This is inside of our container. We could access this file by entering a bash terminal in our container, or we can inspect this container. Luckily the maintainers of this container knew we need the first time setup code, and made it available within the logs of the container.

Run ``docker logs jenkins`` to bring up the logs for our jenkins container.

You are looking for a line like this:

.. image:: /_static/images/docker-jenkins/jenkins-config.png

Enter that password into the Unlock Jenkins page you can find at ``localhost:7070``.

.. image:: /_static/images/docker-jenkins/unlock-jenkins.png

Click continue. On the next page select ``Install suggested plugins`` and give it a few minutes to install everything Jenkins needs.

Additional Information
----------------------

You are running Jenkins inside of a container, which is a virtual machine inside your computer. Jenkins usually includes testing, and will need to be able to access the testing database. You will need to reference the IP address of the database. If you have your database running in a container you will need to use ``docker inspect psql-airwaze`` (make sure to use the name of your database container) to view the internal IP address of your database.
