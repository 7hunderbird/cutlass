#!/usr/bin/env bash

set -eu

setup_and_login() {
    # put all the bucc generated environment variables in our shell
    source <(bucc/bin/bucc env)

    # a quick way to create a bosh alias to our bucc server
    bosh alias-env bucc/bin/bucc

    # now we're ready to login
    bosh login
}

# virtualbox returns with double-quotes
# state_json is only the string
virtualbox=$(VBoxManage list vms | tail -n 1 | awk '{print $1}')

if [[ -f bucc/state/state.json ]]; then
  state_json=$(cat bucc/state/state.json | jq -r .current_vm_cid)
fi

if [[ ! -f bucc/state/state.json ]]; then

    echo "Bosh is not running... Starting bucc."

    bucc/bin/bucc up

    setup_and_login

# therefore we use the *contains* syntax so the string of $state_json
# is contained within $virtualbox.
elif [[ $virtualbox == *$state_json* ]]; then

    echo "Bosh is running, logging in."

    setup_and_login

fi
