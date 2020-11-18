VPC -> subnets -> create subnet

select your VPC

- take note of the VPC ID

subnet settings

- name: <name>-private-subnet-01
- AZ: first choice (us-east-1a)
- CIDR: 10.0.2.0/24 (leave .0.0 and .1.0 for public, .2.0 and .3.0 private)

!! wont be able to touch anything external (s3, yum packages etc) without a NAT gateway !!

VPC -> NAT gateways -> create

- name: `<Name>NATGateway`
- subnet: the public subnet
- allocate elastic IP ("static" IP)
  create -> copy NAT gateway ID

VPC -> route tables -> Main route table for VPC -> Routes -> edit routes

go to Route Tables -> search by VPC: <VPC ID>

- see 2 entries
  - Main (private, default)
  - custom (public)

select Main

- see Routes are constrained to VPC only (no IGW)
- add route: 0.0.0.0/0 - NAT (select `<Name>NATGateway`)
- subnets tab -> edit associations
- select <name>-private-subnet-01 (10.0.2.0/24) -> save

select custom (Main: No)

- see Routes include VPC and IGW (all non-VPC matched addresses - 0.0.0.0/0)
- subnets tab -> see public subnet (10.0.0.0/24)
- PUBLIC just means the subnet is associated with a route table that has an IGW route

go to SGs -> create SG

- no reason to use NACLs since we are restricting by "instance purpose (SG)" not IP (more dynamic)

web server SG (apply to all WS instances, reference DB SG outbound)

- name: `<Name>PublicWebServer`
- description: SG for public facing web servers
- VPC: your VPC
  inbound rules
- HTTP (anywhere)
- HTTPS (anywhere)
  outbound rules
- HTTP (anywhere)
- HTTPS (anywhere)

db SG (apply to all DB instances, reference WS SG inbound)

- name: `<Name>PrivateDbServer`
- description: SG for private DB servers
- VPC: your VPC
- inbound rules
  - PostgreSQL (5432, source search for `<Name>PublicWebServer`)
- outbound rules
  - HTTP (anywhere - but could be more restrictive as needed)
  - HTTPS (same)

go back to SGs and select `<Name>PublicWebServer`

- edit outbound rules:
  - PostgreSQL (5432, source search for `<Name>PrivateDbServer`)
    save

launch instance (DB)

- new instance (micro)
- linux 2 AMI (private subnet, use docker init script)
- SGs -> select existing -> (SSH instructors, SSH personal, `<Name>PrivateDbServer`)
- choose existing SSH key -> acknowledge -> create

!! make DB with public IP for troubleshooting then remove IP / move to private subnet? !!
!! or give init script to guarantee it works without requiring entry <--- second choice !!
!! or set up jumpbox? <--- preferred (unless we using existing host as temporary jumpbox) !!
!! common SSH key or have them share theirs with us so we can SSH? !!

SSH into existing API host

- shut down db
- update `DB_HOST` in service config to point at new DB instance private IP
- restart service and confirm working

go to EC2 -> find existing API instance -> instance state -> terminate

launch instance (API)

- new instance (micro this time)
- linux 2 AMI (public subnet, use java-service user data script)
- SGs -> select existing -> (SSH instructors, SSH personal, `<Name>PublicWebServer`)
- choose existing SSH key -> acknowledge -> create
