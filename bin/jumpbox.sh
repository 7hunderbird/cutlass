#!/usr/bin/env bash

set -eux

bosh int state/creds.yml --path /jumpbox_ssh/private_key > jumpbox.key
chmod 600 jumpbox.key
ssh jumpbox@192.168.50.6 -i jumpbox.key
