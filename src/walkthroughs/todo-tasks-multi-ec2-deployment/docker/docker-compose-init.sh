#! /usr/bin/env bash

# -ex: exit on error and print every command issued for debugging
set -ex

# -- SET ENV VAR VALUES -- #

# ex: lc-nga-c7-vamp-artifacts
ARTIFACTS_BUCKET_NAME=

# ex: /todo-api
PROJECT_ARTIFACTS_PREFIX=

# -- END ENV VARS -- #

# install docker engine
amazon-linux-extras install docker
# enable the service to automatically start on reboots
# --now: starts after enabling
systemctl enable --now docker

# add the ec2-user (non-root) to the docker group
# so we can run docker without running as root (security risk)
# https://docs.docker.com/install/linux/linux-postinstall/
# -aG: a[ppend] G[roup] <group name> <to user name>
usermod -aG docker ec2-user

# install docker-compose
# uname: -s for system name, -m for machine hardware name
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# make compose executable
chmod +x /usr/local/bin/docker-compose

# pull down the compose content
aws s3 sync "s3://$ARTIFACTS_BUCKET_NAME/$PROJECT_ARTIFACTS_PREFIX/" .docker

# start up the services
# the () is a sub-shell expression
# will perform the commands without effecting this (parent) shell
# meaning this shell (executing the script) wont change directories
(cd .docker && docker-compose up -d)