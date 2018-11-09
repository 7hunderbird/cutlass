#!/usr/bin/env bash

set -eux

# download bucc https://github.com/starkandwayne/bucc
# this file can be embedded in the repo root

# our source code for the Cloud Foundry deployment
CF_DEPLOYMENT=src/cf-deployment

# if $CF_DEPLOYMENT exists git pull, otherwise git clone to $CF_DEPLOYMENT
if [[ -d "$CF_DEPLOYMENT" ]]; then
  git -C $CF_DEPLOYMENT pull
else
  git clone https://github.com/cloudfoundry/cf-deployment.git $CF_DEPLOYMENT
fi

# *after* the git repo is updated, or version will be inaccurate
STEMCELL_VERSION=$(bosh interpolate $CF_DEPLOYMENT/cf-deployment.yml --path /stemcells/alias=default/version)

# determine the ubuntu code name
CODE_NAME=$(bosh interpolate $CF_DEPLOYMENT/cf-deployment.yml --path   /stemcells/0/os)

# upload cloud config to director
bosh -n ucc $CF_DEPLOYMENT/iaas-support/bosh-lite/cloud-config.yml

# upload stemcell to director
bosh \
  upload-stemcell \
  https://bosh.io/d/stemcells/bosh-warden-boshlite-${CODE_NAME}-go_agent?v=${STEMCELL_VERSION}

# Uses the 10.244.0.34 ip from cf-deployment bosh-lite.yml operator file
# https://github.com/cloudfoundry/cf-deployment/blob/master/operations/bosh-lite.yml

bosh -n -d cf deploy $CF_DEPLOYMENT/cf-deployment.yml \
    --vars-store state/cf-deployment-vars.yml \
    -v "system_domain=sys.10.244.0.34.xip.io" \
    -o $CF_DEPLOYMENT/operations/bosh-lite.yml \
    -o $CF_DEPLOYMENT/operations/use-compiled-releases.yml

# we created --vars-store state/cf-deployment-vars.yml in above deploy. Use the cf_admin_password.
CF_ADMIN_PASSWORD=$(bosh interpolate state/cf-deployment-vars.yml --path /cf_admin_password)

# refresh routes
sudo route delete 10.244.0.0/16
bucc routes

# login to cf-cli
cf login --skip-ssl-validation -a https://api.sys.10.244.0.34.xip.io -u admin -p $CF_ADMIN_PASSWORD

# create a target
cf create-space default -o system

# target default
cf target -o "system" -s "default"
