#!/bin/bash

set -o pipefail

EPOCH=$1
CAR_PATH=$2
INDEX_PATH=$3
# Check if the epoch number is a number
re='^[0-9]+$'

if ! [[ $EPOCH =~ $re ]]; then
  echo "Epoch number is not a number"
  exit 1
fi

if [ -z "$CAR_PATH" ]; then
  echo "CAR_PATH is empty"
  exit 1
fi

if [ -z "$INDEX_PATH" ]; then
  echo "INDEX_PATH is empty"
  exit 1
fi

faithful-cli index gsfa --epoch=$1 $CAR_PATH $INDEX_PATH
