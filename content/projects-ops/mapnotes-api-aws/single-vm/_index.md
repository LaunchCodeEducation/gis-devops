## Minimal Expectations

### Autonomy

### Competency

### Exposure

## Scenario

<!-- prompt -->
<!-- diagram -->

## Requirements

### Hosting

- Use S3 to deliver artifacts
- In the host EC2:
  - Run the MapNotes API as a startup service
  - Run the PostgreSQL container as a startup service
  - Run the Nginx reverse proxy as a startup service

### Security

- Only allow S3 access from the host EC2
- Only expose HTTP web traffic
- Only expose SSH traffic to your home IP

## Recipes

{{% notice info %}}
The following recipes are used in this deployment. For additional challenge try completing it without opening the recipe links!
{{% /notice %}}

- [Configure a Linux Java host]({{< ref "recipes/linux-host-java" >}}) --> abstract common /_index.md, move remainder to /java.md
- [Configure a Linux docker-compose host]({{< ref "recipes/linux-host-docker-compose" >}})
- [Configure Nginx reverse proxy]({{< ref "recipes/nginx-reverse-proxy" >}})
- [Configure a Linux SystemD startup service]({{< ref "recipes/systemd/startup-service" >}})
- [Configure EC2 service role for S3 access]({{< ref "recipes/aws-ec2-s3-service-role" >}})
