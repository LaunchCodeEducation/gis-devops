:orphan:

.. _walkthrough-jenkins:

====================
Walkthrough: Jenkins
====================

Follow along with the instructor as we configure Jenkins.

Setup
=====

For this example we will be using the same project. Fork and Clone `this repository <https://gitlab.com/LaunchCodeTraining/airwaze-jenkins>`_.

For this to work your Airwaze tests need to pass.

* Open your Airwaze project and run the tests
* If they don't pass, then fix them ;)

Our Continous Integration Goals
===============================

After a branch/story is merged into our ``master`` branch. We want...

1. Make sure the master branch still compiles after the merge
2. Make sure the tests still pass
3. Deliver a ``.jar`` file that is ready to be deployed

To accomplish these goals we will need to...

#. Install & Configure Jenkins
#. Create a Jenkins user
#. Create a Compile Project
#. Create a Test Project
#. Create a Create Jar Project
#. Create a Deliver Jar Project

Install and Configure Jenkins
=============================

To install and configure Jenkins for use checkout the :ref:`docker-jenkins` article.

Create a Jenkins User
=====================

#. Create User
#. Login with User

* This will be how you login to jenkins going forward
* Be sure to remember the username and password
* All fields are required
* Click **Save and Continue**
* Click **Save**
* Click **Start using Jenkins**

  * You may have to stop Jenkins and restart it

Login to Jenkins
----------------

* Enter the username and password you just created

Create Project to Compile Airwaze
=================================

#. Create & Name New Item
#. Configure Compile Project
#. Git Integration
#. Add Action -- Create Gradle Task
#. Try It Out
#. Console Output
#. Workspace
#. Trigger Next Project when Compile Project is Successful

* Click **New Item**
* Enter name ``Airwaze Compile``
* Click **Freestyle Project**
* Click **Ok** at bottom

Configure the Compile Project
-----------------------------

* In **Source Code Management** click **Git**
* Post your SSH gitlab repo url into **Repository URL**. Example: git@gitlab.com:welzie/airwaze-studio.git
* Make sure you the branch you want to compile is in the **Branch Specifier** field
* Go to the **Build Triggers** section
* Select **Poll SCM** and enter ``H/5 * * * *`` into the **Schedule** input
* Go to the **Build** section
* Click **Add build step**
* Click **Invoke Gradle script**
* Select **Use Graddle Wrapper**
* Enter ``clean compileJava`` into the **Tasks** input
* Click **Save**

  * You will be taken to the **Project Airwaze Compile** page

Let's Build It and See What Happens
-----------------------------------

* Can we build it? Yes we can!
* Click **Build Now** in the left menu

  * The #1 build can be seen running in the build window

* Click on the **#1** in the **Build History** when the build has finished

  * You will be taken to the **Build #1** page
  * This page has all the details for what happened on this build

* Click on **Console Output** in the left menu

  * Here you can see exactly what commands were executed

* Click **Airwaze Compile** in the top menu under the Jenkins logo

  * This will take you back to the Project page
  * On the project page you can run another build or see the history for other builds

We Need to Install a Plugin
---------------------------

* Click **Jenkins** in the top menu, the menu below the Jenkins logo
* Click **Manage Jenkins** on the left
* Click **Manage Plugins** on the right
* Click **Available**
* Enter **Parameterized Trigger** in search box
* Check the checkbox next to the one result that matches
* Click Install **Parameterized Trigger plugin** without restarting
* Click **Back to Dashboard**

Create Test Project
===================

#. Create & Name New Item
#. Configure Test Project
#. Add Action -- Trigger Gradle Task
#. Environment Variables
#. DB Access
#. Try It Out
#. Trigger Next Project when Test Project is Successful

Create CreateJar Project
========================

#. Create & Name New Item
#. Configure Create Jar Project
#. Add Action -- Trigger Gradle Task
#. Try It Out
#. Trigger Next Project when Test Project is Successful

Create Deliver Jar Project
==========================

#. Create & Name New Item
#. Configure Deliver Jar Project
#. Add Action -- Trigger Shell Script
#. AWSCLI From Docker Container
#. Try It Out

Next Steps
==========

#. Deploy API
#. CI/CD for Client App
#. See the same Process using a different tool (GitLabCI, Travis, etc)

Create Test, CreateJar, and Deliver Projects
===============================================

* Create three more **Freestyle** projects
* ``Airwaze Test``
* ``Airwaze CreateJar``
* ``Airwaze Deliver``
* Don't do anything but give these a name and click **Save**

  * We will configure them next

Edit the Compile Project
========================

We need the **Compile Project** to kick off the **Test Project** when it's done. We also want the two projects to share the same work space, so that the repo doesn't have to be checked out again.

* Go back to the **Dashboard**
* Click the **Airwaze Compile** Project
* Click **Configure**
* Go to **Post Build Actions**
* Select **Trigger parameterized build on other projects** from the select box
* Enter ``Airwaze Test`` as the project to build
* Click **Add Parameters** and select **Build on the same node**
* Click **Add Parameters** again and select **Predefined parameters**
* Enter this ``AIRWAZE_WORKSPACE=${WORKSPACE}`` into input
* Click save

Configure Test Project
----------------------

* Navigate to project ``http://localhost:9090/job/Airwaze%20Test/``
* Click **Configure**
* In **General** select **This project is parameterized**
  String Parameter

  .. image:: /_static/images/parameter-project-1.png

* Paste this ``AIRWAZE_WORKSPACE`` into **name** input

Enter parameter name

  .. image:: /_static/images/parameter-project-2.png

* Click **Advanced** button and select **Custom Workspace**
* Enter ``${AIRWAZE_WORKSPACE}`` in the input

Custom Workspace Direstory

  .. image:: /_static/images/parameter-project-3.png

* Go to the **Build** section
* Click **Add build step**
* Click **Invoke Gradle script**
* Select **Use Graddle Wrapper**
* Enter ``clean test`` into the **Tasks** input

Now we need to kick off the **CreateJar Project**

* Go to **Post Build Actions**
* Enter ``Airwaze CreateJar`` as the project to build
* Click **Add Parameters** and select **Build on the same node**
* Click **Add Parameters** again and select **Predefined parameters**
* Enter this ``AIRWAZE_WORKSPACE=${WORKSPACE}`` into input
* Click save

Run the Compile Project, which runs the Test Project
----------------------------------------------------

* Run the Compile Project

  * Go to the **Dashboard**
  * Click the **Compile Project**
  * Click **Build Now**
  
* After both the Compile Project and Test Project have finished
* You can view the tests by finding the test results in the project work space
* Naviage to project works space by clicking **Work Space** in the left menu of a project. Example: http://localhost:9090/job/Airwaze%20Test/ws/
* Once on the **Work Space** page click on the folder names and navigate to ``/build/reports/tests/test/index.html``
* Clicking on ``index.html`` should open up the junit test results. Example: http://localhost:9090/job/Airwaze%20Test/ws/build/reports/tests/test/index.html

Configure the Tests Results to be Published Automatically
---------------------------------------------------------

* We can configure the tests results to be pushlised on the project results after every run
* Go to the **Post build actions** for the **Test Project**
* Select **Publish JUnit test result report** and input this ``build/test-results/test/*.xml`` into input
* Run the project again and you will see a link named **Latest Test Results** on the project page
* You can also click on a specific build and see a link named **Test Results**
* NOTE: a graph will appear on the project page that shows a history of test results

Configure CreateJar Project
---------------------------

* Same configuration as the **Test Project**, with these exceptions
* In the **Build** section 
* Enter this gradle command ``bootRepackage`` into **Tasks** input
* Select **Use Graddle Wrapper**
* Go to **Post Build Actions**
* Select **Trigger parameterized build on other projects** from the select box
* Enter ``Airwaze Deliver`` as the project to build
* Click **Add Parameters** and select **Build on the same node**
* Click **Add Parameters** again and select **Predefined parameters**
* Enter this ``AIRWAZE_WORKSPACE=${WORKSPACE}`` into input
* Click save

Setup S3 Bucket (Needed so we can configure the next project)
-------------------------------------------------------------

* If you haven't already, you need to install ``awscli``. Instructions can be found in the `AWS3 Studio <https://education.launchcode.org/gis-devops/studios/AWS3/>`_
* Create a new S3 bucket that will be used for the ``.jar`` files your jenkins builds produce

::

  $ aws s3 mb s3://launchcode-gis-c3-blake-airwaze

* Go to the AWS website and enable **VERSIONING**

Make sure your s3 bucket shows up when you run this command in terminal::

  $ aws s3 ls


Configure Deliver Project
-------------------------

* Same configuration as **CreateJar Project**, with these two exceptions
* In the *Build* section select **Execute shell**
* Enter this into input ``aws s3 cp build/libs/app-0.0.1-SNAPSHOT.jar s3://YOUR-S3-BUCKET/``
* There are NO **Post Build Actions**

That's It!
==========

Now run the **Airwaze Compile** project now and watch it kick off the other projects automatically!
