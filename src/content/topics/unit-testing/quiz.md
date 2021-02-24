---
title: "Unit Testing Quiz"
date: 2021-02-11T18:34:35Z
summary: ""
weight: 4
categories: ["quizzes"]
# TODO: add any other related tags before committing
tags: ["unit-testing"]
---

## To Test Or Not To Test

For each of the following questions identify whether the function/method is a good candidate for unit testing. Think about the justification for your answers.

> A function, `add()`, that sum two numbers.

<!-- true -->

1. true
2. false

> A function, `getProjectData()`, which *makes an HTTP request* to gather project data.

<!-- false -->

1. true
2. false

> A constructor method for a `User` class that assigns values to their respective fields.

<!-- false -->

1. true
2. false

> A constructor method for a `User` class that *validates values* before assigning them to their respective fields.

<!-- true -->

1. true
2. false

## Designing Unit Tests

Review the following pseudocode to answer the following questions:

```py
# capitalizes the first character of a string
function capitalize(word):
  if word is not a string:
    throw an InvalidArgument error

  if word is an empty string:
    return word
  
  # word[1:] is all characters starting at 1st index
  return word[0].uppercase() + word[1:].lowercase()
```

> How many logical branches are there?

<!-- 3 -->

1. 1
2. 2
3. 3
4. 4

> Which of the following tests would be appropriate to include?

<!-- 
- given a number it throws an `InvalidArgument` error
- given a boolean it throws an `InvalidArgument` error
-->

- given a number it throws an `InvalidArgument` error
- given a paragraph it capitalizes all the first letters of each sentence
- given a boolean it throws an `InvalidArgument` error
