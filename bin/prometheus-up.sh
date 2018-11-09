#!/usr/bin/env bash

set -eux

export BOSH_RELEASE=src/prometheus-boshrelease

#
# ensure $BOSH_RELEASE exists, otherwise clone to $BOSH_RELEASE
if [[ -d "$BOSH_RELEASE" ]]; then
  git -C $BOSH_RELEASE pull
else
  git clone https://github.com/bosh-prometheus/prometheus-boshrelease $BOSH_RELEASE
fi

# *after* the git repo is updated, or version will be inaccurate
export STEMCELL_VERSION=$(bosh interpolate $BOSH_RELEASE/cf-deployment.yml --path /stemcells/alias=default/version)
#
# # upload cloud config
# bosh -n ucc $BOSH_RELEASE/iaas-support/bosh-lite/cloud-config.yml
#
# # upload stemcell
# bosh \
#   upload-stemcell \
#   https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent?v=${STEMCELL_VERSION}
#
# # Uses the 10.244.0.34 ip from cf-deployment bosh-lite.yml operator file
# # https://github.com/cloudfoundry/cf-deployment/blob/master/operations/bosh-lite.yml
#
bosh -d prometheus deploy $BOSH_RELEASE/manifests/prometheus.yml \
  --vars-store state/prometheus-deployment-vars.yml
#
# # passwords are here:
# cat state/prometheus-deployment-vars.yml
