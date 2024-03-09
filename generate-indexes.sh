#!/bin/bash

CAR_PATH=$1
INDEX_PATH=$2

if [ -z "$CAR_PATH" ]; then
  echo "CAR_PATH is empty"
  exit 1
fi

if [ -z "$INDEX_PATH" ]; then
  echo "INDEX_PATH is empty"
  exit 1
fi

faithful-cli index all $CAR_PATH $INDEX_PATH
