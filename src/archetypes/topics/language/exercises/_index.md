---
title: "Exercises"
date: {{ .Date }}
summary: ""
# slides (1) and walkthroughs (2) come before exercises in ToC sidebar
weight: 3
# tags the topic
# TODO: add the tool-name and any other related tags before committing
tags: ["{{ replace .Name '-' ' ' }}", ""]
---

{{% notice info %}}
Exercises are designed to give you isolated practice on a topic. Solutions are not provided but your instructor can go over any you are unsure of with you.
{{% /notice %}}

## Exercises

{{% children style="h3" sort="weight" %}}
