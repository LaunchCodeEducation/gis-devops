---
title: "Java/J-Unit"
date: 2021-02-11T18:34:35Z
summary: ""
categories: ["java"]
# tags the topic
# TODO: add the tool-name and any other related tags before committing
tags: ["integration-testing", "j-unit", "mockmvc"]
---

## Prerequisites

{{% notice warning %}}
In order to learn this implementation you need to know the learning objectives of the following prerequisite implementations:
{{% /notice %}}

1. [Java/J-Unit: Unit Testing]({{< ref "topics/unit-testing/java-j-unit/" >}})

## Content

{{% children style="h3" depth=1 sort="weight" %}}

## Learning Objectives

{{% notice note %}}
In addition to the learning objectives listed here you are responsible for the [base learning objectives]({{< ref "../" >}}).
{{% /notice %}}

<!-- Syntax or terms specific to the langauge/tool  -->

### Terminology

> For the following list you should know the purpose and have an example to relate it to:

- `MockMvc`
- `MockMvcRequestBuilders`
- `MockMvcResultMatchers`
- `andExpect()`
- `jsonPath()`
- `@IntegrationTestConfig`
- `@BeforeAll`
- `@AfterAll`
- JMESPath

<!-- Specific best practices or conventions related to the given language/tool -->

### Concepts

> You should be able to discuss the following:

- How environment variables are passed to Gradle and the JVM

<!-- Specific usage of the language/tool -->

### Capabilities

> You should be able to:

- Use `docker-compose` to set up and tear down a testing database
- Use the Gradle wrapper with environment variables to execute integration tests
- Use provided testing utility classes to set up integration tests
- Design and write `MockMvc` statements to simulate HTTP request
  - method and path
  - headers
  - serialized body
- Design and write HTTP assertions using `MockMvc` `andExpect` statements
  - response bodies using JSON path syntax
  - response status codes and headers
- Design and write database assertions using appropriate Model Repositories
