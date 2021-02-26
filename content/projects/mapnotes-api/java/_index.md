---
title: "Java/Spring Implementation"
date: 2021-02-02T20:31:55Z
summary: ""
## TODO: add/remove tags before committing
tags: ["projects", "api", "java", "spring"]
---

<!-- 
language specific implementation requirements / overview
 -->

This is the assigned project page with specific requirements and details for this tech stack. Refer to the [project overview]({{< ref "../" >}}) for general information, functional requirements and any other implementations of the project.

## Tech Stack

| | |
| --- | --- |
| **Language** | Java |
| **Framework** | Spring Boot |
| **Build Tool** | Gradle |
| **Testing Framework** | Junit 5 |
| **Backing Services** | PostgreSQL + PostGIS DB |

{{% notice tip %}}
Your gradle dependencies and tasks have been provided for you review them in the `build.gradle` file.
{{% /notice %}}

## Instructions

### Workflow
<!-- TODO: add ref when article is up -->

### Setup

Fork and clone the Map Notes API [java/spring starter repository](https://gitlab.com/LaunchCodeTraining/zika-project/mapnotes-api).

<!--
As you work toward your objectives remember to use feature branches and regular lean commits. 
When you complete this project assign your instructors to a merge request.

TODO: create dedicated dev submission article w/ assessment criteria
- link to it in all projects it applies to
-->

### Running the Project

There is some provided code, largely files, and some empty methods. The project has been given to you in a stable state. You can run this project with `bootRun` or you can test this project with `test`.

To make things easier for you while you work on this project we have created a `run.sh` script that allows you to quickly and easily run the gradle `test` and `bootRun` commands.

Try them out after cloning this project to your computer.

#### Running Test

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

#### Running Dev

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

## Technical Requirements

### REST

Refer to the [REST spec on main project page]({{< ref "../#api-specification" >}})

### External Configuration

In the application.properties file in the provided starter code the following environment variable keys have been provided:

```sh
spring.datasource.url=jdbc:postgresql://${MAPNOTES_API_DB_HOST}:${MAPNOTES_API_DB_PORT}/${MAPNOTES_API_DB_NAME}
spring.datasource.username=${MAPNOTES_API_DB_USER}
spring.datasource.password=${MAPNOTES_API_DB_PASSWORD}
```

- MAPNOTES_API_DB_HOST
- MAPNOTES_API_DB_PORT
- MAPNOTES_API_DB_NAME
- MAPNOTES_API_DB_USER
- MAPNOTES_API_DB_PASSWORD

### Serialization

The majority of the completed files involve JSON serialization and de-serialization. The jackson library is pretty good at serializing JSON to and from standard Java library code, however, it isn't perfect.

The jackson library isn't able to (de)serialize geo information out of the box. There are some additional third party libraries that can assist with this, but for the convenience of this project we have provide two custom serialization classes:

- ``models/Feature/utils/FeatureCollectionSerializer.java``
- ``models/Feature/utils/FeatureCollectionDeSerializer.java``

These files do exactly what they say. They de-serialize a GEOJSON representation of a FeatureCollection to a usable FeatureCollection Java object and vice versa. You can look at how the files work, but learning about custom (de)serialization is not a topic we will explore in this class.

You are still responsbile for completing generic JSON serializations by implementing the following DTO classes:

- `InboundNoteRepresentation.java`
- `OutboundNoteRepresentation.java`
- `Feature.java`
- `FeatureCollection.java`

Refer to the [JSON Representations on the main project page]({{< ref "../#json-representations" >}})

### GeoJSON

Your integration tests inside `NoteFeatureController/` must adhere to the GeoJSON spec.

Refer to the [GeoJSON Representations on the main project page]({{< ref "../#json-representations" >}})

### ORM

You will be responsbile for the provided models:

- `NoteEntity.java`
- `NoteFeatureEntity.java`

{{% notice tip %}}
Remeber your NoteEntity has a one to many relationship with NoteFeatureEntity.
{{% /notice %}}

Refer to the [JSON Representations on the main project page]({{< ref "../#json-representations" >}})

### Integration Testing

You will be responsbile for the provided integration testing files:

- `GetNoteFeaturesTests.java`
- `PutNoteFeaturesTests.java`
- `GetNoteTests.java`
- `DeleteNoteTests.java`
- `GetNotesTests.java`
- `PutNotesTests.java`

You are responsbile for testing **all endpoint conclusions** in this application.

Refer to the [REST spec on main project page]({{< ref "../#api-specification" >}}) for a refresher on the endpoints required for this application.

{{% notice tip %}}
Your integration tests are responsbile for testing HTTP responses & Database interactions.
{{% /notice %}}

#### Testing Utilities

Two files have been created to help you with writing your tests:

- ``TestUtils/NoteDataTestUtil.java``
- ``NoteFeatureEntityUtil.java``

``NoteDataTestUtil.java`` is currently commented out, so that your code will compile, but after adding in the necessary code you can comment it in, and it will assist you in creating test notes.

``NoteFeatureEntityUtil.java`` is a class with one static method ``getTestNoteFeatureEntities()``. This method will return a List of NoteFeatureEntity objects. This List of NoteFeatureEntity objects *is necessary* for writing tests around the ``/notes/{id}/features`` endpoints. You can look at this file to see how it created this test object if you would like to add more test data.

### Unit Testing

You will be responsbile for the provided unit testing files:

- `InboundNoteRepresentationTests.java`
- `OutboundNoteRepresentationTests.java`

### TDD

You are expected to follow TDD practices while coding this application.

{{% notice warning %}}
Check in with your instructor after writing your tests before moving into implementation.
{{% /notice %}}

<!-- 
#### Swagger

https://www.baeldung.com/swagger-2-documentation-for-spring-rest-api  (provide annotation config; submit a swagger doc via annotations)
-->

## Submission
<!-- TODO: add ref when article is up -->
Refer to the [project submission guide]({{ < ref "" >}})

## Suggested Approach

1. Get notes collection
2. Get note entity
3. Delete note entity
4. Create note entity
5. Get a note's features
6. Save a note's features

<!-- TODO: turn each suggested approach into subheaders and add additional things that will need to be done (from a high level) look into shortcodes for making the subsections collapsable -->