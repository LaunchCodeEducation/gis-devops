#! /usr/bin/env bash

# -ex: exit on error and print every command issued for debugging
set -ex

# TODO: fill these in to customize to your project
# -- SET ENV VAR VALUES -- #
ARTIFACTS_BUCKET_NAME=
PROJECT_ARTIFACTS_PREFIX=
# -- END ENV VARS -- #

# -- INSTALL DEPENDENCIES -- #

# enable the package sources through amazon-linux-extras
amazon-linux-extras enable java-openjdk11 nginx

# install through yum after enabling the sources
yum clean metadata && yum -y install java-11-openjdk nginx

# -- END DEPENDENCIES -- #

# pull down the artifacts
# expects: *.jar, *.service, *.config, *nginx.conf files
artifacts_dir=/tmp/artifacts
service_name=api.service
aws s3 sync "s3://$ARTIFACTS_BUCKET_NAME/$PROJECT_ARTIFACTS_PREFIX/" "$artifacts_dir"

# TODO: create API user and dirs
# TODO: move artifacts to appropriate dirs
mv "$artifacts_dir/"*.service "/etc/system/systemd/api.service"

# TODO: enable and start the service