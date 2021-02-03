---
title: "Java/Spring Implementation"
date: 2021-02-02T20:31:55Z
summary: ""
# TODO: add/remove tags before committing
tags: ["projects", "api", "java", "spring"]
---

<!-- 
language specific implementation requirements / overview
 -->

This is the assigned project page with specific requirements and details for this tech stack. Refer to the [project overview]({{< ref "../" >}}) for general information, functional requirements and any other implementations of the project.

# Tech Stack

<!-- table
language (java) (python)
framework (spring boot) (flask)
build tool (gradle) (pip)
dependencies (...) (...)
backing services (postgis container)
dev tools (docker-compose, bash)
 -->
- Java / Spring Boot
- Gradle
- Spring Boot Test / Junit5
- Spring Boot Data JPA / Hibernate
- PostgreSQL + PostGIS extension container

# Instructions

## Setup

Fork and clone the Map Notes API [java/spring starter repository](https://gitlab.com/LaunchCodeTraining/zika-project/mapnotes-api).

<!--
As you work toward your objectives remember to use feature branches and regular lean commits. 
When you complete this project assign your instructors to a merge request.

TODO: create dedicated dev submission article w/ assessment criteria
- link to it in all projects it applies to
-->

## Running the Project

There is some provided code, largely files, and some empty methods. The project has been given to you in a stable state. You can run this project with `bootRun` or you can test this project with `test`.

To make things easier for you while you work on this project we have created a `run.sh` script that allows you to quickly and easily run the gradle `test` and `bootRun` commands.

Try them out after cloning this project to your computer.

### Running Test

<!-- TODO: use vscode test runner config for embedded execution / results -->

You can run your tests from the root of your project with:

```sh
./run.sh test
```

This command will:

- start a testing database container
- run all of your automated tests
- launch a python web server at `localhost:4000` if any tests fail or exit gracefully if all tests pass

If any tests fail the command will automatically open a Python web server with the test results at `localhost:4000`. If you have failing tests and you want to stop the `run.sh test` command you can do so with `Ctrl+C`.

{{% notice note %}}
If you are running this right after cloning, you will notice all of the tests fail. This is to be expected. If you look at the provided tests they are empty except for one assert statement that will always fail. You are responsible for writing valid tests for this API.
{{% /notice %}}

### Running Dev

If you want to kick off the gradle `bootRun` task you can do so from the root of your project with:

```sh
./run.sh dev
```

This command will:

- start a development database container
- start the bootRun command
- start the Tomcat web server

At this point you would be able to use `curl` to manually test your API as you develop.

{{% notice warning %}}
If you see the following error:
{{% /notice %}}

```sh
Connection to localhost:5432 refused. Check that the hostname and port are correct and that the postmaster is accepting TCP/IP connections.
```

Your Tomcat web server started before your development database container was completely setup. Typically your application will continue to keep attempting to establish a connection and will eventually connect. If you see a different error mentioning the database, hibernate, or JPA let your instructor know for troubleshooting assistance!

You can exit this command with `Ctrl+C`.

## Submission
<!-- TODO: add ref when article is up -->
Refer to the [project submission guide]({{ < ref "" >}})

# Gotchas

# Limited Guidance