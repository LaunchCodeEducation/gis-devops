.. _project_mapnotes-api:

======================
Project: Map Notes API
======================

Map Notes API
=============

Currently our Zika Client consumes a Map Notes service that was provided for us in a docker container. This project week we will be building our own Map Notes API in Java/Spring.

The Map Notes API endpoints:

- GET /notes -> (Note[]) 200
- POST /notes ({title, body}) -> (Note) 201
- GET /notes/{id} -> (Note) 200
- DELETE /notes/{id} -> 204
- GET /notes/{id}/features -> (GeoJSON feature collection) 200
- PUT /notes/{id}/features (GeoJSON feature collection) -> 201

Your objective for this project week is to build the Map Notes API in Java/Spring that follows the spec listed above.

Requirements
============

- All endpoint conclusions must have passing integration tests
- Any request that contains a path variable that doesn't exist in the database must return a 404 status code
- DTOs must be used for incoming and outgoing JSON representations
- API data must be persisted to a postgres database

Setup
=====

Git
---

Fork and clone the `Map Notes API starter repository <https://gitlab.com/LaunchCodeTraining/zika-project/mapnotes-api>`_.

As you work toward your objectives remember to use feature branches and regular lean commits.

When you complete this project assign your instructors to a merge request.

Running the Project
-------------------

There is some provided code, largely files, and some empty methods. The project has been given to you in a stable state. You can run this project with ``bootRun`` or you can test this project with ``test``.

To make things easier for you while you work on this project we have created a ``run.sh`` script that allows you to quickly and easily run the gradle ``test`` and ``botRun`` commands.

Try them out after cloning this project to your computer.

Using ``run.sh`` with test
^^^^^^^^^^^^^^^^^^^^^^^^^^

You can run your tests from the root of your project with:

.. sourcecode:: bash

    ./run.sh test

This command will:

- start a testing database container
- run all of your automated tests
- launch a python web server at ``localhost:4000`` if any tests fail or exit gracefully if all tests pass

If any tests fail the command will automatically open a Python web server with the test results at ``localhost:4000``. If you have failing tests and you want to stop the ``run.sh test`` command you can do so with ``Ctrl+C``.

Using ``run.sh`` with dev
^^^^^^^^^^^^^^^^^^^^^^^^^

If you want to kick off the gradle ``bootRun`` task you can do so from the root of your project with:

.. sourcecode:: bash

    ./run.sh dev

This command will:

- start a development database container
- start the bootRun command
- start the Tomcat web server

At this point you would be able to use ``curl`` to manual test your API as you develop.

.. admonition:: warning

    If you see an error that reads:

        Connection to localhost:5432 refused. Check that the hostname and port are correct and that the postmaster is accepting TCP/IP connections.
    
    Your Tomcat web server started before your development database container was completely setup. Typically your application will continue to keep attempting to establish a connection and will eventually connect. If you see a different error mentioning the database, hibernate, or JPA let your instructor know for troubleshooting assistance!

You can exit this command with ``Ctrl+C``.

Setup Conclusion
----------------

At this point in time you have enough information that you can start working on this project. Make sure to follow the spec provided above, and to test all of your endpoint conclusions.

If you feel like you have an understanding of how you would start go for it.

If you want a little more guidance stick around.

.. admonition:: note

    The first thing you should do with this project is look over the provided code. Not much has been provided for you in this project. Most files indicate (through code comments) if they are completed or if you will need to work in them. Ask yourself what needs to be accomplished in each file.

Limited Guidance
================

Continuing with the practice of providing less assistance in project weeks we will only provided limited guidance in this write up. As usual feel free to talk through logic, syntax, and troubleshooting with your instructors.

Following project tradition **you are forbidden from sharing code with other students**, but you are more than welcome to talk about the project together.

Utilize Tests Early
-------------------

Our first piece of advice is to utilize automated testing! Not only is this a requirement for this project, but it will speed up your development time considerably.

If you can write an integration test for the step you are currently working on, you can very quickly get results. This also allows you to develop easier features first. If you are manually testing your project with ``curl`` you would need to build your POST and PUT functionality *before* your GET or DELETE functionality. You would need to do that because it is impossible to manually test a GET or DELETE until some data exists.

With automated testing you can work on GET first, because your test can add the testing data to your database without requiring the POST, or PUT functionality to exist in your source code.

Isolate the tasks
-----------------

Focus on one endpoint at a time. If you decide to work on the functionality for the ``GET /notes -> (Note[]) 200`` endpoint first, finish it before moving on to another section. If you focus purely on this endpoint you only have to focus on the necessary files and code to achieve this functionality.

The test files have been separated in a fashion that should encourage this isolation, however, it is up to you to keep yourself on track.

Start with the easier tasks
---------------------------

You may have noticed throughout this class the amount of code you need write for some of the endpoints is rather minimal. We recommend starting with those lighter tasks:

- GET
- GET by id
- DELETE by id

Accomplishing the lighter tasks first will give you some additional practice with Java/Spring and integration testing without introducing too much complex logic. This will also give you time to work on the more difficult tasks.

In addition to starting with the easier tasks, complete the ``/notes`` endpoint first. ``Map Notes`` own ``Features``, however you don't have to worry about the relationship between Map Notes and Features at the beginning of this project. ``Map Notes`` are a complete entity and you can finish all of their associated endpoints without touching Features at all.

Suggested Primary Objectives
============================

We won't require you to follow a strict list of primary objectives like previous project weeks. However, for those of you that like the structure they provide for branching strategies we recommend completing the endpoints in the following order:

- GET /notes -> (Note[]) 200
- GET /notes/{id} -> (Note) 200
- DELETE /notes/{id} -> 204
- POST /notes ({title, body}) -> (Note) 201
- GET /notes/{id}/features -> (GeoJSON feature collection) 200
- PUT /notes/{id}/features (GeoJSON feature collection) -> 201

Turning in Your Work
====================

Git Workflow
------------

As you work on your project you will be required to **commit early and commit often**. Part of your review will include an assessment of your usage of git. You are expected to have a history of commits documenting your progress through the use of **descriptive commit messages**. 

Your git history should include **separate branches for each primary objective** titled `objective-#` which contains all the commits associated with its completion.

After completing each objective you can `git merge` the objective feature branch back into your master branch. Make sure that you **push your branches** to the remote repo on GitLab after completing each of the primary objectives. This includes pushing the `master` branch after each objective branch is merged into it.

.. admonition:: Warning

  **When you complete your final objective** you will open a Merge Request (MR) on GitLab to merge that objective feature branch into `master`. Notify your instructor so they can begin your code review.

Code Review
-----------

After opening your MR your instructor will review your code and leave feedback. If changes are requested due to an incomplete or non-functioning objective you will be required to implement the suggested changes and push them up for further review. When your instructor has confirmed that your objectives are complete you can work on the Secondary and Bonus objectives!

Presentation
------------

Typically at the end of the week we try to have project presentations where everyone gets a chance to show their project to the rest of the class. Due to the remote nature of this course we may try to do this, or we may skip this. Either way be prepared to show and talk about your project at the end of the project week.

At the end of this course, during your graduation ceremony, you will be expected to present your final project to the attendees. Every project week we will have a presentation as a way for you to practice for this final presentation.

.. Bonus Resources
.. ===============

.. * `CSS Selectors <https://www.w3schools.com/cssref/css_selectors.asp>`_
.. * `JSON Lint <https://jsonlint.com/>`_
.. * `geojson.io <http://geojson.io/#map=2/20.0/0.0>`_
.. * `Spring Data JPA DataRepostiry query documentation <https://docs.spring.io/spring-data/jpa/docs/1.5.0.RELEASE/reference/html/jpa.repositories.html>`_

.. .. note::

..    Remember that both jQuery and OpenLayers will silently fail if they are not given valid JSON and valid GeoJSON (respectively).
