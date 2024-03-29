#!/bin/bash

set -o pipefail

# Check if there is an epoch number provided
if [ $# -eq 0 ]; then
  echo "Missing START_EPOCH, END_EPOCH"
  exit 1
fi

START_EPOCH=$1
END_EPOCH=$2

# Check if the epoch number is a number
re='^[0-9]+$'

if ! [[ $START_EPOCH =~ $re ]]; then
  echo "Start epoch number is not a number"
  exit 1
fi

if ! [[ $END_EPOCH =~ $re ]]; then
  echo "End epoch number is not a number"
  exit 1
fi

if [ $START_EPOCH -lt 0 ]; then
  echo "Epoch number is less than 0"
  exit 1
fi

if [ $START_EPOCH -gt $END_EPOCH ]; then
  echo "START_EPOCH must less than END_EPOCH"
  exit 1
fi

# Create the epochs directory
mkdir -p epochs

# Create the epochs files
for epoch in $(seq $START_EPOCH $END_EPOCH); do

  echo "Generating epoch $epoch"
  # get cid from url
  cid=$(curl -fs https://files.old-faithful.net/$epoch/epoch-$epoch.cid)

  if [ $? -ne 0 ]; then
    echo "Failed to get cid for epoch $epoch"
    exit 1
  fi

  cat <<EOF >"epochs/epoch-$epoch.yml"
epoch: $epoch
version: 1
data:
  filecoin:
    enable: false
  car:
    uri: "https://files.old-faithful.net/$epoch/epoch-$epoch.car"
indexes:
  cid_to_offset:
    uri: "https://files.old-faithful.net/$epoch/epoch-$epoch.car.$cid.cid-to-offset.index"
  slot_to_cid:
    uri: "https://files.old-faithful.net/$epoch/epoch-$epoch.car.$cid.slot-to-cid.index"
  sig_to_cid:
    uri: "https://files.old-faithful.net/$epoch/epoch-$epoch.car.$cid.sig-to-cid.index"
  sig_exists:
    uri: "https://files.old-faithful.net/$epoch/epoch-$epoch.car.$cid.sig-exists.index"
EOF
done
