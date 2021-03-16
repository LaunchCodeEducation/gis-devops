---
title: "Zika Client Deployment: AWS S3"
date: 2021-03-11T20:31:32Z
summary: ""
categories: ["projects"]
tags: ["aws", "s3", "client"]
---

## Minimal Expectations

### Autonomy

- terminal

### Competency

- Cloud Service Provider: AWS
- AWS S3: CLI
- NPM scripting

### Exposure

- build tool
- HTTP

## Scenario

{{% notice info %}}
Your instructor will provide the hosted GeoServer URL and artifacts according to the course schedule.
{{% /notice %}}

In order to make your client publicly accessible it must be hosted on the internet. The HTML, CSS and JavaScript files that make up the Zika Client are static making them a perfect candidate for AWS S3 web hosting.

### GeoServer

Your client will now need to consume a publicly hosted GeoServer. Fortunately you will not be responsible for deploying it at this time.

## Requirements

- Use the AWS CLI to deploy the Zika Client to S3.
- The deployment should be automated using an NPM script.

### Hosting

- Host the Zika Client on AWS S3 as a static web server.

### Security

- Content should have public read access only.

## Deliverables

1. The hosted S3 URL of your Zika Client.
2. Open a merge request which adds a functional NPM `"deploy"` script.

## Recipes

{{% notice note %}}
For additional challenge try completing the project without opening the recipe section below.
{{% /notice %}}

{{% expand "The following recipes are used in this deployment:" %}}

- [Configure AWS S3 Web Hosting]({{< ref "" >}})
{{% /expand %}}
