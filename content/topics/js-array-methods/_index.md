---
title: "JavaScript: Array Methods"
date: 2021-03-01T19:16:32Z
summary: ""
categories: ["javascript"]
tags: ["callbacks", "arrays"]
---

## Prerequisites

{{% notice warning %}}
In order to learn this topic you need to know the learning objectives of the following prerequisite topics:
{{% /notice %}}

1. [JavaScript: Fundamentals]({{< ref "topics/js-fundamentals/" >}})
1. [JavaScript: Callbacks]({{< ref "topics/js-callbacks/" >}})

## Content

{{% children style="h3" depth=1 sort="weight" %}}

## Learning Objectives

{{% notice info %}}
After learning this topic you are expected to reach the **Competence** level of the following objectives.
{{% /notice %}}

### Terminology

> For the following list you should know the purpose and have an example to relate it to:

- `forEach()`
- `filter()`
- `map()`
- `sort()`

<!--
- `reduce()`

IDEA: expand to introduce reduce
- show chaining and simplification using reduce
-->

### Concepts

> You should be able to discuss the following:

- The signatures of common iterative array method callbacks.
- The output of common iterative array methods.
- The benefits of using iterative array methods.

<!-- CLARITY: for "The benefits of using iterative array methods. 

Students definitely know what each one does, their syntax, and their purpose. But from the notes I think they would say the benefit is abstraction? Is that what we want them to take away from array methods? 

If not I would recommend another benefits slides, or a recap slide that talks about why the array methods are beneficial. 

response:

great points. i think the benefits are
- reduced verbosity (chance of error)
- reusability (cbs are portable if defined externally)
- immutability (following a FP principle)
-->

### Capabilities

> You should be able to:

- Use `sort()` to sort an array in forward and reverse order.
- Use `filter()` to separate the elements of an array.
- Use `map()` to transform the elements of an array.
