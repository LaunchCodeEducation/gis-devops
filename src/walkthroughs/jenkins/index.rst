:orphan:

.. _walkthrough-jenkins:

===============================
Walkthrough: CI/CD With Jenkins
===============================

Follow along with the instructor as we configure Jenkins.

Setup
=====

For this example we will be using the same project. Fork and Clone `this repository <https://gitlab.com/LaunchCodeTraining/airwaze-jenkins>`_.

For this to work your Todo API tests need to pass.

* Open your Todo API project and run the tests
* If they don't pass, then fix them ;)

Our Continuous Integration & Delivery Goals
===========================================

After a branch/story is merged into our ``master`` branch. We want...

#. Make sure the master branch still compiles after the merge
#. Make sure the tests still pass
#. Create a ``.jar`` file
#. Deliver the ``.jar`` file to expedite deployment

To accomplish these goals we will need to...

#. Install & Configure Jenkins
#. Create a Jenkins user
#. Install Plugin
#. Create Empty Projects
#. Build Todo API Compile
#. Link Projects Together
#. Configure Todo API Compile
#. Configure Todo API Test
#. Configure Todo API CreateJar
#. Configure Todo API Deliver

Install and Configure Jenkins
=============================

To install and configure Jenkins check out the :ref:`docker-jenkins` article.

Once you have installed and setup Jenkins you should see the home page:

.. image:: /_static/images/jenkins/jenkins-home.png

Install Plugin - Parameterized Trigger
======================================

Before we get started in creating our Jenkins Projects we are going to install the ``Parameterized Trigger`` plugin. This plugin will allow us to link Jenkins Projects together (trigger), and have all the projects share the same workspace (parameters).

On the left hand side of the Jenkins Home page you should see a button labeled ``Manage Jenkins`` click it now. You should see the Manage Jenkins page that looks something like this:

  .. image:: /_static/images/jenkins/manage-jenkins.png

Click the Manage Plugins button (it looks like a loose puzzle piece).

That should take you to this page:

  .. image:: /_static/images/jenkins/plugin-manager.png

Select the ``Available`` tab and then use the ``Filter`` box to search for ``Parameterized Trigger`` which should look like this:

  .. image:: /_static/images/jenkins/search-parameterized-trigger.png

Select the checkbox for this plugin and click the ``Install without restart`` button. This will take you to a new page and may take a couple of minutes to completely install.

After the plugin is installed completely return to the Jenkins Home Page, by clicking the Jenkins Icon in the top left of your browser.

Create Empty Projects
=====================

We need to create 4 projects in Jenkins, for now we just want to name them and save them.

The projects we want to create are:

- Todo API Compile
- Todo API Test
- Todo API CreateJar
- Todo API Deliver

For each project:

- Click New Item
- Enter in the Project Name
- Click Freestyle Project
- Click OK
- On the configure project screen click Save

Following is a walkthrough for the first project Todo API Compile. You will need to do this four times for all of the projects we need for this pipeline.

From the Jenkins Homepage click ``New Item``:

.. image:: /_static/images/jenkins/jenkins-home.png

This will take you to a page like this:

.. image:: /_static/images/jenkins/new-item.png

Put in the Item name: ``Todo API Compile``, click ``Freestyle project``, and then click the OK button. This should take you to the Configure Project screen:

.. image:: /_static/images/jenkins/configure-new-item.png

For now we aren't going to configure anything, so just click the Save button.

Repeat the Create new Item steps for all four of our projects: Todo API Compile, Todo API Test, Todo API CreateJar, and Todo API Deliver and then return to the Jenkins Homepage which should look like this:

.. image:: /_static/images/jenkins/empty-items.png

Build Todo API Compile
=====================

To familiarize ourselves with how Jenkins works let's try building one of our projects. We haven't added any actions to our project yet, but Jenkins will still run it for us. From your Jenkins dashboard click on your ``Todo API Compile`` project. This takes you to the homepage for this specific project and looks like:

.. image:: /_static/images/jenkins/project-homepage.png

From here click on the ``Build Now`` button on the left-hand menu. This will schedule a build that should start immediately. You should see that your build history has changed and now has one build in it like the following image:

.. image:: /_static/images/jenkins/build-history.png

Let's click on that build (it should be a link) and look at the page for this specific build:

.. image:: /_static/images/jenkins/build-page.png

From here click on ``Console Output`` so we can see what came out of the terminal when this build was run in our Jenkins Container:

.. image:: /_static/images/jenkins/console-output.png

The Console Output is pretty sparse, which makes sense, we haven't told Jenkins to do anything for us in this build yet! The output is just letting us know where this project's workspace is, and this build was successful. The workspace is where all of the files for this project would live. Any built artifacts, or .jar files, test results, etc.

However, we don't want to manually trigger all of these individual projects. In the next section we will add some configurations to our existing projects so they will automatically build when a previous project was successful.

Link Projects Together
======================

We know the order of our projects:

#. Todo API Compile
#. Todo API Test
#. Todo API CreateJar
#. Todo API Deliver

So let's use the parameterized trigger plugin we installed earlier to run our projects in this order. Navigate to the ``Todo API Compile`` homepage and click ``Configure`` which should take you back to the project configuration screen:

.. image:: /_static/images/jenkins/configure-new-item.png

From here we want to add a ``Post build Action`` so click the tab or scroll towards the bottom of this page until you see:

.. image:: /_static/images/jenkins/post-build-action.png

Click the drop-down menu and select ``Trigger parameterized build on other projects``:

.. image:: /_static/images/jenkins/trigger-parameterized-build.png

This will create a new section in which you will need to enter the next project to build ``Todo API Test``, and then you will have to add two parameters using the ``Add Parameters`` drop-down box: ``build on the same node`` and ``Predefined parameters``. In the Predefined parameters section add: ``TODO_WORKSPACE=${WORKSPACE}`` and click the ``Save`` button.

.. image:: /_static/images/jenkins/post-build-action-2.png

We have told Jenkins that when the ``Todo API Compile`` project is successful that it should automatically schedule and run ``Todo API Test``. We have instructed Jenkins to run the next project on the same node, and that we will be passing it one parameter. The parameter key is ``TODO_WORKSPACE`` and the value is ``${WORKSPACE}``. This is how we share the same workspace between the two projects.

Our workspace is what contains our built artifacts, and all of the files of our project. We want this to be used by all projects so that we don't have to keep pulling these files into each individual project.

Now we will need to configure our ``Todo API Test`` project to receive this parameter, and to use the workspace that is being passed in. Open the ``Todo API Test`` project, and click configure:

.. image:: /_static/images/jenkins/configure-general.png

In the ``General`` section we need to select the ``This project is parameterized`` checkbox and we need to add a new ``String Parameter`` from the ``Add Parameter`` drop-down menu. In the ``String Parameter`` section add ``TODO_WORKSPACE`` to the Name field. This is our way of letting this project know the previous project will be passing in one parameter, and we should name it TODO_WORKSPACE.

We now need to configure a custom workspace for this project. At the bottom of the ``General`` section you should see a button labeled ``Advanced`` click that button to see more options including ``Use custom workspace``. Check the ``Use custom workspace`` checkbox and enter ``${TODO_WORKSPACE}`` we are using the parameter passed in from the previous section here:

.. image:: /_static/images/jenkins/custom-workspace.png

Double check that you have selected ``This project is parameterized``, you added the new ``String Parameter`` that represents our workspace, and added the ``Use custom workspace`` and set it's directory to the parameter that was passed in and click ``Save``.

Let's try it out to make sure it worked. Navigate to your ``Todo API Compile`` project, and click ``Build now``. When it's completed it should automatically fire your next project ``Todo API Test``.

Now we will need to add the conditions to continue passing the workspace and triggering the next builds. Using the steps we followed above you will need to:

- Add a post build action to ``Todo API Test``
- Add parameters, and custom workspace to ``Todo API CreateJar``
- Add a post build action to ``Todo API CreateJar``
- Add parameters, and custom workspace to ``Todo API Deliver``

After making the additional amendments to ``Todo API Test``, ``Todo API CreateJar``, and ``Todo API Deliver`` build ``Todo API Compile`` and watch Jenkins run through all four of our projects. Your dashboard should look like this:

.. image:: /_static/images/jenkins/all-projects-build.png

Now that all of our projects are in an automated pipeline let's start adding some actual build actions to our projects!

Configure Todo API Compile
=========================

Our first project is to compile our code. In order to do this we will first need to get our code into the hands of Jenkins. We will do this within our first project ``Todo API Compile``. Go to the Configure project screen for ``Todo API Compile`` and select the ``Source Code Management`` header, or scroll to that section:

  .. image:: /_static/images/jenkins/source-control.png

Select ``Git``. From here you will need to provide the URL to your git repository: ``https://gitlab.com/LaunchCodeTraining/todo-tasks-api-solution``

And the branch to pull from this repository: ``*/master``. 

It should looks something like this:

.. image:: /_static/images/jenkins/source-control-completed.png

.. note::

   If you are attempting to pull from a private git repository you will have to give Jenkins the proper credentials. In GitLab the easiest way is to create a ``Deploy Token`` and paste the token information into the credentials section of the repository. You can find ``Deploy Tokens`` under ``Settings->Repository`` from the GitLab web interface.

This will give this Jenkins project the ability to pull from your Git repository and to store the files it pulls into it's workspace. Let's try it out! 

Click Save, and then build now. 

After the build finishes click on ``Workspace``. You should notice now that it pulled all your files from Git:

  .. image:: /_static/images/jenkins/workspace-from-git.png

.. tip::

   You may also want to checkout the ``Console Output`` for this specific build, it is showing us the output from the actual commands run by Jenkins. You will probably see some information about Git connecting to and pulling down files from the referenced Git URL.

Now that we have the files from GitLab we can compile them! We will do that with a Gradle Task. Configure ``Todo API Compile`` one last time. This time navigate to the ``Build`` section and ``Add a build step`` which ``Invoke Gradle script``:

  .. image:: /_static/images/jenkins/invoke-gradle-compile.png

We want to select ``Use Gradle Wrapper``, and then we need to include the gradle tasks we want to run. Let's run ``clean`` and ``compileJava``.

Now the Jenkins project ``Todo API Compile`` will pull down our code from GitLab, run the Gradle tasks ``clean`` and ``compileJava`` and if all three of those things are successful it will trigger the next Jenkins project ``Todo API Test``.

Run this project again and make sure it is still successful letting us know the code that was pulled from GitLab was compiled successfully. We can verify this by looking at the console output for this most recent build:

.. image:: /_static/images/jenkins/invoke-gradle-compile-output.png

.. Tip::

   After running ``Build Now`` again checkout the ``Console Output`` of this Jenkins project Build. We now see some familiar Gradle messages about running tasks and if they were successful or not. The ``Console Output`` is a very beneficial tool for troubleshooting your Jenkins projects.

.. TODO: refactor section 

Configure Todo API Test
======================

In our pipe we have pulled down our code from GitLab, and we have successfully compiled it. Since we are sharing one workspace between all of our Jenkins Projects we simply need to run a Gradle ``test`` script to verify all of our tests pass.

Recall the Todo Tasks API has a full suite of integration tests. As a part of our Jenkins setup we also spun up a Postgis container for the very purpose of letting Jenkins run tests. We want to run our tests before we attempt to build and deliver a jar file.

Navigate to the ``Configure`` tab of your ``Todo API Test`` and add a build step for ``Invoke gradle script`` like the following:

.. image:: /_static/images/jenkins/configure-todo-api-test.png

After configuring the ``test`` task as the build action for the ``Todo API Test`` save and run then run the ``Todo API Compile`` task. We want to ensure our tests passed:

.. image:: /_static/images/jenkins/successful-tests.png

According to the console output of the ``Todo API Tests`` our tests ran successfully!

.. comment::

    ref

    .. note::

    You can read more about how this, and other networking mechanisms, work in the :ref:`docker-networking` article. 

Finally Let's save this Jenkins project, and run ``Build Now`` on our ``Todo API Compile`` project to see if ``Todo API Test`` passes.

Configure Todo API CreateJar
===========================

Now that we have compiled our code, and passed all of our tests, let's create a ``.jar`` file that can be deployed on a server.

``Configure`` your ``Todo API CreateJar`` project. Select, or scroll down to the ``Build`` section. ``Add build step`` and ``Invoke Gradle script``, select ``Use Gradle Wrapper`` and enter ``bootJar`` as our Gradle task:

  .. image:: /_static/images/jenkins/create-jar.png

After filling out this Project click save.

If you look in the current workspace of ``Todo API CreateJar``, or either of the other projects we have configured you will notice we don't have a ``build/libs/`` directory, after we run this task we should.

That's all we need to do for this Jenkins project. So let's kick the whole pipe off by running ``Build Now`` on ``Todo API Compile``.

If it worked successfully you should now find a ``build/libs/todo-0.0.1-SNAPSHOT.jar`` file that was created by this project. Thanks Jenkins!

.. image:: /_static/images/jenkins/todo-jar.png 

Configure Todo API Deliver
=========================

Our final step for today will be delivering our newly minted ``build/libs/todo-0.0.1-SNAPSHOT.jar`` file to an AWS S3 bucket that can be incorporated in our deployment process.

Configure the ``Todo API Deliver`` project and add a new build action execute shell:

.. image:: /_static/images/jenkins/execute-shell.png

We will be adding the following bash command that will copy the jar file to our artifacts bucket:

.. code:: bash

  aws s3 cp build/libs/todo-0.0.1-SNAPSHOT.jar s3://<your-bucket-name>/todo/todo-app.jar

.. image:: /_static/images/jenkins/todo-deliver.png

Finally, save and build your ``Todo API Compile`` project again. After all four of our projects have run check the console output of the last ``TODO API Deliver`` task that completed:

.. image:: /_static/images/jenkins/jar-copied-to-s3.png

You can also check the file by running: ``aws s3 ls s3://<your-bucket-name>/todo/`` which should show one file ``todo-app.jar``.

.. image:: /_static/images/jenkins/jar-in-s3.png

Continuous Integration?
=======================

As our Jenkins pipeline stands right now it's not automatic. We have to login to Jenkins and click the run build action on our ``Todo API Compile`` task. So although we have a Jenkins pipe that does all the work up to Delivery for us, we still hav to manually engage with it.

You could say this pipeline isn't continuously integrated because it requires human interaction. We want the ``Todo API Compile`` project to engage automatically when a new change is pushed to master.

What is necessary for our Jenkins Pipeline to automatically fire? Communication.

There are essentially two options:

- Our Jenkins Pipeline needs to check the GitLab repository for changes at some interval
- The GitLab repository needs to send a notification to our Jenkins Pipeline after a change has been made

Currently our Jenkins Pipeline is running in a development environment because it's tied to our local development machine. GitLab would need to make a web request to Jenkins in order to trigger a build action. 

To configure this would take a bunch of steps in your own personal home LAN. It would also probably break some rules in the contract you have with your Internet Service Provider. So we can't have GitLab contact our Jenkins pipeline because it is running on our machine.

However, we can configure our Jenkins Pipeline to check our GitLab repo every so often for changes. If it detects changes it can kick off the ``Todo API Compile`` task automatically.

Add Poll SCM to ``Todo API Compile``
------------------------------------

Navigate to the ``Todo API Compile`` project and click Configure. Scroll down to ``Build Triggers`` and check ``Poll SCM``:

.. image:: /_static/images/jenkins/build-trigger-poll-scm.png

We will be adding a `Cron job <https://www.man7.org/linux/man-pages/man5/crontab.5.html`_ this is a linux tool for scheduling specific tasks. In this case we will be scheduling this ``Poll SCM`` to check our GitLab repo every five minutes.

After entering in the valid crontab syntax: ``*/5 * * * *`` for run every five minutes click save.

Now check the ``Git Polling Log`` tab of our ``Todo API Compile`` project:

.. image:: /_static/images/jenkins/todo-api-compile-git-polling-no-changes.png

You may have to wait a couple of minutes but you will eventually see output like the line above. It checked the main branch of our GitLab repo and didn't detect any changes, so no task was fired.

Your instructor will make a change to the master branch and after five minutes you should see an update to this tab:

.. image:: /_static/images/jenkins/todo-api-compile-git-polling-changes-found.png

Jenkins detected a change to the master branch and automatically triggered the ``Todo API Compile`` project. Which succeed and propagated through our pipeline of linked projects.

You can see that all of the tasks ran by looking at 

Next Steps: Bonus
=================

Deploy Jenkins
--------------

Right now our Jenkins Pipeline is using SCM Polling to detect changes, however this is pretty inefficient because the Jenkins container must be running on your local machine to poll the GitLab repo, and it does so every five minutes. Not only is this wasteful, it's a pipeline that shuts down anytime your machine shuts down or loses internet access.

The next step for this Pipeline would be to deploy it. You could easily create a new VPC, with a public subnet and one EC2 for Jenkins. You could then move Jenkins over to that EC2 and re-configure your pipeline.

Use the GitLab Plugin to Trigger Builds
---------------------------------------

You could then use the ``GitLab Plugin`` and configure a ``Build Trigger`` on a change to the master branch that would send a web-request to Jenkins! This is what would fire the ``Todo API Compile`` project and engage the pipeline.

Expanding the Functionality of the Jenkins Pipeline
---------------------------------------------------

With CI/CD the sky is the limit. Whatever regular tasks that need to be performed we can add to our Pipeline.

Right now Jenkins is only delivering one JAR file to the S3 bucket. What other files does our EC2 depend on?

- nginx.conf
- docker-compose.yml
- Systemd unit file
- possibly a docker env file

You could easily add a new task that would send these files to the S3 artifacts bucket as well, which would make your deployment even easier.

If you really wanted to get crazy with it you could add a bash script that can be ran that will remove the old JAR file, copy the new JAR file with the AWS CLI, stop the todo-app.service, start the todo-app.service which in essence is the remainder of our deployment steps. 

You could add this bash script to your list of additional build artifacts and have our Pipeline push it to the S3 bucket.

Additional Bonus Tasks
----------------------

Our Jenkins pipeline only takes us through Delivery, but doesn't automatically Deploy our ``jar`` file. Looking into AWS Code PipeLine could help us take this pipe all the way to deployment...

Other ideas to implement:
  #. Trigger ``Todo API Compile`` on GitLab merge to your forked repo
  #. CI/CD for your Zika Client
  #. Try setting up a pipeline with the same stages using a different tool (GitLabCI, Travis, etc)
