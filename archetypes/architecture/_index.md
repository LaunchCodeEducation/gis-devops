---
title: "PROJECT NAME CSP: {{ replace .Name "-" " " | title }}"
date: {{ .Date }}
summary: ""
categories: ["projects", "ops"]
# TODO: add/remove tags before committing
tags: [""]
---

## Minimal Expectations

### Autonomy

### Competency

### Exposure

## Scenario

<!-- prompt -->
<!-- diagram -->

## Requirements

### Hosting

<!-- TODO: hosting requirements

- Use S3 to deliver artifacts
- In the host EC2:
  - Run the MapNotes API as a startup service
  - Run the PostgreSQL container as a startup service
  - Run the Nginx reverse proxy as a startup service
-->

-

### Security

<!-- TODO: security requirements

- Only allow S3 access from the host EC2
- Only expose HTTP web traffic
- Only expose SSH traffic to your home IP
-->

-

## Recipes

{{% notice info %}}
The following recipes are used in this deployment. For additional challenge try completing it without opening the recipe links!
{{% /notice %}}

<!-- TODO: add the related recipes

- [Configure a Linux Java host]({{< ref "recipes/linux-host-java" >}})
- [Configure a Linux docker-compose host]({{< ref "recipes/linux-host-docker-compose" >}})
- [Configure Nginx reverse proxy]({{< ref "recipes/nginx-reverse-proxy" >}})
- [Configure a Linux SystemD startup service]({{< ref "recipes/systemd/startup-service" >}})
- [Configure EC2 service role for S3 access]({{< ref "recipes/aws-ec2-s3-service-role" >}})
-->

-
