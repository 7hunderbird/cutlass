#!/usr/bin/env bash

set -eux

# our source code for the cf-mysql-deployment
export CF_MYSQL_DEPLOYMENT=src/cf-mysql-deployment

# if $CF_MYSQL_DEPLOYMENT exists git pull, otherwise git clone to $CF_MYSQL_DEPLOYMENT
if [[ -d "$CF_MYSQL_DEPLOYMENT" ]]; then
  git -C $CF_MYSQL_DEPLOYMENT pull
else
  git clone https://github.com/cloudfoundry/cf-mysql-deployment.git $CF_MYSQL_DEPLOYMENT
fi

export SYSTEM_DOMAIN=sys.10.244.0.34.netip.cc
export CF_ADMIN_PASSWORD=$(bosh interpolate state/cf-deployment-vars.yml --path /cf_admin_password)

# upload bosh release of cf-mysql-release to director
# bosh \
#   upload-release \
#   https://bosh.io/d/github.com/cloudfoundry/cf-mysql-release

# upload cloud config to director
bosh -n ucc $CF_MYSQL_DEPLOYMENT/bosh-lite/cloud-config.yml

# deploy cf-mysql to the director
bosh -n -d cf-mysql deploy $CF_MYSQL_DEPLOYMENT/cf-mysql-deployment.yml \
  --vars-store state/mysql-creds.yml \
  -o $CF_MYSQL_DEPLOYMENT/operations/add-broker.yml \
  -o $CF_MYSQL_DEPLOYMENT/operations/bosh-lite.yml \
  -o $CF_MYSQL_DEPLOYMENT/operations/latest-versions.yml \
  -o $CF_MYSQL_DEPLOYMENT/operations/register-proxy-route.yml \
  --vars-file $CF_MYSQL_DEPLOYMENT/bosh-lite/default-vars.yml \
  -v cf_mysql_external_host=p-mysql.$SYSTEM_DOMAIN \
  -v cf_mysql_host=$BOSH_ENVIRONMENT \
  -v cf_admin_password=$CF_ADMIN_PASSWORD \
  -v cf_api_url=https://api.$SYSTEM_DOMAIN \
  -v cf_skip_ssl_validation=true

# register service broker
# https://github.com/cloudfoundry/cf-mysql-deployment#registering-broker
bosh -d cf-mysql run-errand broker-registrar
