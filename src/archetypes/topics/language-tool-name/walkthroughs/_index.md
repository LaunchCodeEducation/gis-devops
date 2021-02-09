---
title: "Walkthroughs"
date: {{ .Date }}
summary: ""
# walkthroughs come after slides (1) and exercises (2)
weight: 3
categories: ["walkthroughs"]
# tags the topic
# TODO: add the tool-name and any other related tags before committing
tags: ["{{ replace .Name '-' ' ' }}", ""]
---

<!--
reference images using a relative path: ./images/image-name.ext
-->

{{% notice info %}}
Walkthroughs are designed to give you guided practice on the implementation of a topic. During class time your instructor will lead the walkthrough while you follow along and ask questions.
{{% /notice %}}

{{% notice tip %}}
You can complete walkthroughs on your own for additional practice or use them as a reference during your projects.
{{% /notice %}}

## Walkthroughs

{{% children style="h3" depth=1 sort="weight" %}}
