---
title: "MapNotes API"
date: 2021-02-02T20:31:55Z
summary: ""
categories: ["projects"]
tags: ["api", "gis"]
---

<!-- TODO: update archetype -->

## Minimal Expectations

{{% notice info %}}
In order to complete this project you must reach the following levels of the prerequisite topics:
{{% /notice %}}

### Autonomy

- HTTP
- Terminal
- Git: Fundamentals

<!-- 
- HTTP
  - autonomy implies capability
    - postman
    - curl
- Git: Fundamentals
  - version control system
  - repository
  - commit
  - branch
  - commands
    - add
    - commit
    - push
    - pull
    - checkout
    - clone
- terminal
  - CLI
  - profiles
  - invoking programs
  - commands
    - navigation
    - CRUD
  - zsh
    - build on bash
    - set up (walkthrough)
      - zshrc
      - oh-my-zsh + plugins
-->

### Competency

- Git: Collaboration
- GeoJSON
- REST: Fundamentals
- REST: Development
- DTO
- Integration Testing
- Unit Testing
- TDD
- Swagger

{{% notice note %}}
For the [Java Implementation](./java/) you will also need:
{{% /notice %}}

- Hibernate: Fundamentals
- Hibernate: O2M

<!-- 
- Git Collaboration
- JSON
  - GeoJSON
- REST Fundamentals
- REST Development
- DTO
  - purpose
  - validation
  - security
  - considerations
  - representation
  - implementations
    - java DTO 
- (FUTURE) Spring: Serialization
  - jackson
  - annotations
  - general idea of custom serializers
  - (ALTERNATE) just write it into the project writeup
- integration testing
- unit testing
- TDD
- Swagger
-->

### Exposure

- ORM
- Build Tool
- SQL: Relationships
- Docker Compose: Fundamentals
- Dependency Management
- Environment Variables

<!-- 
- SQL: Relationships
  - back links SQL: Fundamentals
- build tool
- docker-compose usage
- dependency management
- ORM
  - general concept
  - behavior
  - purpose
  - models
  - relationship considerations
    - CRUD implicit behavior
- environment variables
  - external configuration
  - environment parity
  - implementations
    - gradle: systemProperties, -D, ...
    - webpack: env plugin, process.env ...
    - sysd
    - docker-compose
- Build Tool
  - build automation
  - tasks (dev, test, build)
  - implementations
    - Gradle
    - Webpack
- Dependency Management
  - purpose
  - registries
  - versioning
  - implementations
    - Gradle
    - NPM
-->

## Overview

Currently our Client consumes a Map Notes service that was provided for us. This project week we will be building our own Map Notes API.

## Functional Requirements

This API project will require you to adhere to the RESTful specification below as well as general API requirements.

### API Specification

The Map Notes API endpoints:

<!-- vscode snippet -->
| Method | Path | Request Body | Response Body | Status |
| --- | --- | --- | --- | --- |
| GET | `/notes` | | `OutboundNote[]` | 200 |
| POST | `/notes` | `InboundNote` | `OutboundNote` | 201 |
| GET | `/notes/{id}` | | `OutboundNote` | 200 |
| DELETE | `/notes/{id}` | | | 204 |
| GET | `/notes/{id}/features` | | `FeatureCollection` | 200 |
| PUT | `/notes/{id}` | `FeatureCollection` | | 201 |

#### JSON Representations

Your implementation should adhere to the following JSON shapes:

{{% notice note %}}
The following are generic JSON data types. Refer to your implementation for the data types of your language.
{{% /notice %}}

> `OutboundNote`:

```js
{
  "id": number,
  "title": string,
  "body": string
}
```

> `InboundNote`:

```js
{
  "title": string,
  "body": string
}
```

> `Feature`:

```js
{
  "id": number,
  "type": "Feature",
  "geometry": Geometry
}
```

> `FeatureCollection`:

```js
{
  "type": "FeatureCollection",
  "features": Feature[]
}
```

{{% notice note %}}
Refer to the implementation for the `Geometry`. For additional information look at the offical [GeoJSON spec](https://geojson.org/).
{{% /notice %}}

### API Requirements

- All endpoint conclusions must have passing integration tests
- Any request that contains a path variable that doesn't exist in the database must return a 404 status code
- Geospatial data must adhere to the GeoJSON specification
- DTOs must be used for incoming and outgoing JSON representations
- API data must be persisted to a database

## Implementations

{{% notice note %}}
Refer to your course schedule for which implementation to follow.
{{% /notice %}}

- [Java/Spring]({{< ref "java/" >}})
