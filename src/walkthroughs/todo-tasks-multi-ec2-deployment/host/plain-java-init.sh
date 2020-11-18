#! /usr/bin/env bash

# -ex: exit on error and print every command issued for debugging
set -ex

# TODO: fill these in to customize to your project
# -- SET ENV VAR VALUES -- #
ARTIFACTS_BUCKET_NAME=lc-nga-c7-demo-artifacts
PROJECT_ARTIFACTS_PREFIX=todo-api
# -- END ENV VARS -- #

# -- INSTALL DEPENDENCIES -- #

# always update first
yum -y update

# enable the package sources through amazon-linux-extras
amazon-linux-extras enable java-openjdk11 nginx1

# install through yum after enabling the sources
yum -y clean metadata
yum -y install java-11-openjdk nginx

# -- END DEPENDENCIES -- #

# pull down the artifacts
aws s3 cp "s3://$ARTIFACTS_BUCKET_NAME/$PROJECT_ARTIFACTS_PREFIX/" /home/ec2-user/app.jar

#! /usr/bin/env bash

# -ex: exit on error and print every command issued for debugging
set -ex

# TODO: fill these in to customize to your project
# -- SET ENV VAR VALUES -- #
ARTIFACTS_BUCKET_NAME=lc-nga-c7-demo-artifacts
PROJECT_ARTIFACTS_PREFIX=todo-api
# -- END ENV VARS -- #

# -- INSTALL DEPENDENCIES -- #

# always update first
yum -y update

# enable the package sources through amazon-linux-extras
amazon-linux-extras enable java-openjdk11 nginx1

# install through yum after enabling the sources
yum -y clean metadata
yum -y install java-11-openjdk nginx

# -- END DEPENDENCIES -- #

# pull down the artifacts
aws s3 cp "s3://$ARTIFACTS_BUCKET_NAME/$PROJECT_ARTIFACTS_PREFIX/" /home/ec2-user/app.jar

[Unit]
Description=Todo Tasks API
After=syslog.target

[Service]
Type=simple
User=ubuntu
EnvironmentFile=/etc/opt/todo-api/todo-api.config
ExecStart=/usr/bin/java -jar /home/ubuntu/api.jar SuccessExitStatus=143
Restart=always

[Install]
WantedBy=multi-user.target