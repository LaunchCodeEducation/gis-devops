---
title: "Quizzes"
date: {{ .Date }}
summary: ""
# slides (1) and walkthroughs (2) come before exercises in ToC sidebar
weight: 2
# TODO: remove hiding if exercises are added
hidden: true
# TODO: add related tags before committing
tags: ["{{ replace .Name '-' ' ' }}", ""]
---

{{% notice info %}}
Exercises are designed to give you isolated practice on a topic. Solutions are not provided but your instructor can go over any you are unsure of with you.
{{% /notice %}}

## Quizzes

{{% children style="h3" sort="weight" %}}
