#!/usr/bin/env bash

set -eux

# start a bucc server
bucc up

# alias bosh
source <(bucc env)
bosh alias-env bucc
