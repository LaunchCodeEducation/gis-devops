---
# IDEA: auto gen "Topic: Implementation" for easier searching
# TODO: set the parent topic name
title: "TOPIC: {{ replace .Name "-" " " | title }}"
date: {{ .Date }}
summary: ""
# TODO: set category as dev, ops or both
categories: ["topics", ""]
# implementations are hidden and must be directly linked (they have no context without a topic)
hidden: true
# IDEA: auto generate the tag for the parent topic
# TODO: add the parent topic and any other related tags before committing
tags: ["TOPIC"]
---

<!-- TODO: back link to any previous implementation sub-topics (ascending order from root to current topic) -->

<!-- ## Prerequisites

{{% notice warning %}}
In order to learn this implementation you need to understand the learning objectives of the following prerequisite implementations:
{{% /notice %}}

1. [PARENT TOPIC: IMPLEMENTATION]({{< ref "topics/parent-topic/implementation/" >}}) -->

## Content

{{% children style="h3" depth=1 sort="weight" %}}

<!-- ## Learning Objectives

{{% notice note %}}
In addition to the learning objectives listed here you are responsible for the [base learning objectives]({{< ref "../" >}}).
{{% /notice %}} -->

<!-- Syntax or terms specific to the langauge/tool  -->

<!-- ### Terminology

> For the following list you should know the purpose and have an example to relate it to:

-  -->

<!-- Specific best practices or conventions related to the given language/tool -->

<!-- ### Concepts

> You should be able to discuss the following:

-  -->

<!-- Specific usage of the language/tool -->

<!-- ### Capabilities

> You should be able to:

-  -->
