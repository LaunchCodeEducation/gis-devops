---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
summary: ""
categories: ["topics"]
# TODO: add any other related tags before committing
tags: ["{{ replace .Name '-' ' ' }}", ""]
---

<!-- TODO: back link to any previous topics (from root up to current topic) -->

<!-- ## Prerequisites

{{% notice warning %}}
In order to learn this topic you need to know the learning objectives of the following prerequisite topics:
{{% /notice %}}

- [TOPIC]({{< ref "topics/TOPIC" >}}) -->

## Content

{{% children style="h3" depth=1 sort="weight" %}}

<!-- If there is an associated language or tool with this topic all learning objectives should be general/agnostic. Implementation LOs go in the associated language or tool docs -->

<!-- ## Learning Objectives

{{% notice info %}}
After learning this topic you are expected to reach the **Competence** level of the following objectives.
{{% /notice %}} -->

<!-- ### Terminology

> For the following list you should know the definition and have an example to relate it to:

-  -->

<!-- ### Concepts

> You should be able to discuss the following:

-  -->

<!-- ### Capabilities

> You should be able to:

-  -->
