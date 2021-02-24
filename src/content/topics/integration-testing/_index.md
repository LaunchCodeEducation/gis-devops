---
title: "Integration Testing"
date: 2021-02-11T18:34:35Z
summary: ""
categories: ["topics"]
# TODO: add any other related tags before committing
tags: ["integration-testing"]
---

<!-- IDEA: work in embedded vs external integration testing
ex from paul: test geoserver with postman
great way of demoing integration testing without getting into the code
1, describe the API
2. show the test suite
3. run the tests
4. show the implementation code as a lead-in to embedded
-->

<!-- TODO: back link to any previous topics (in order from base down to current topic) -->

## Prerequisites

{{% notice warning %}}
In order to learn this topic you need to know the learning objectives of the following prerequisite topics:
{{% /notice %}}

1. [Testing Fundamentals]({{< ref "topics/testing-fundamentals" >}})
1. [Unit Testing]({{< ref "topics/unit-testing" >}})

## Content

{{% children style="h3" depth=1 sort="weight" %}}

<!-- If there is an associated language or tool with this topic all learning objectives should be general/agnostic. Implementation LOs go in the associated language or tool docs -->

## Learning Objectives

{{% notice info %}}
After learning this topic you are expected to reach the **Competence** level of the following objectives.
{{% /notice %}}

### Terminology

> For the following list you should know the definition and have an example to relate it to:

- integration testing
- system
- components
- testing state
- idempotency
- setup
- teardown

<!-- IDEA: should these go under an environment topic? -->
<!-- - Web Testing Environment
- Parity -->

### Concepts

> You should be able to discuss the following:

- What are the differences between unit and integration testing?
- Why should you write unit tests before integration tests?
- What components are involved in web integration testing?
- Value of maintaining a controlled testing state for each test.
- What roles do setup and teardown play in managing testing state?

<!-- 
IDEA: how to work this best practice in?
- When should you test the shape and count of 
- Difference between superficial (shape, count) and granular assertions (properties)
- Scoping the assertions of an integration test -->


<!-- IDEA: is this worth including?
- Exceptions to testing library code (integration between db models because of complexity and potential for error) -->


<!-- IDEA: how to include this?
- Understand the role environment variables play -->

### Capabilities

> You should be able to:

- Start up a pre-configured testing environment.
- Use pre-written testing utilities as necessary.
- Design and write a web integration test including:
  - setup of initial test state
  - HTTP assertions
  - database assertions
- Use test reports to identify the component involved in a failed integration test.
