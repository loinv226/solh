#!/bin/bash

# Check if there is an epoch number provided
if [ $# -eq 0 ]; then
    echo "No epoch number provided"
    exit 1
fi

START_EPOCH=$1
END_EPOCH=$2

if [ -z "$START_EPOCH" ]; then
  echo "START_EPOCH is empty"
  exit 1
fi

if [ -z "$END_EPOCH" ]; then
  echo "END_EPOCH is empty"
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

cat << EOF > "epochs/epoch-$epoch.yml"
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