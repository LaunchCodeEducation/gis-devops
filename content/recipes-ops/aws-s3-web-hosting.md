---
title: "AWS S3 Web Hosting"
date: 2021-03-16T20:31:32Z
summary: ""
categories: ["recipes", "ops"]
tags: ["aws", "s3"]
--- 


## Prerequisites

{{% notice info %}}
This recipe requires knowledge of the following topics:
{{% /notice %}}

<!-- TODO: update the ref link -->
- [AWS S3: CLI]({{< ref "" >}})

## Use Case

> Deploy a web client

AWS S3 can be used as a static web server in addition to its standard object storage. As a static web server the bucket will serve contents by their file paths:

- The website will be accessible from an `s3-website` subdomain instead of the bucket URL.
- The `index.html` file will be served automatically from the root path, `/`.
- Other content files can be referenced relative to the root path like a file system.

## Steps

The syncing (`sync`) command of the AWS S3 CLI allow us to move local build artifacts to the target bucket. The `website` S3 command can then be used to configure the hosting behavior.

<!-- TODO: update the ref link -->
<!-- topics/aws-s3/cli/provisioning -->
1. [Provision an S3 bucket]({{< ref "" >}}).
2. `sync` the build artifacts **given public read access** with the bucket.
3. Enable web hosting using `website` and the path to the `index.html` entrypoint.

```sh
aws s3 mb <bucket-name>
aws sync --acl public-read build/ s3://<bucket-name>
aws website --index-document index.html s3://<bucket-name>
```

## Confirmation

The hosted site will be available at:

```sh
http://<bucket-name>.s3-website-<region>.amazonaws.com
```

1. load the website URL
1. Check that the root path loads the `index.html` file.
1. Check that any relative links are functioning.

<!-- ## Common Issues -->

<!-- ## Related -->
