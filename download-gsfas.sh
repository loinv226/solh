#!/bin/bash

# Check if there is an epoch number provided
if [ $# -eq 0 ]; then
    echo "Missing START_EPOCH, END_EPOCH, INDEX_PATH"
    exit 1
fi

START_EPOCH=$1
END_EPOCH=$2
INDEX_PATH=$3

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

if [ -z "$INDEX_PATH" ]; then
    echo "INDEX_PATH is empty"
    exit 1
fi

# Create the directory if need
OUTDIR=gsfa
mkdir -p $OUTDIR
mkdir -p $INDEX_PATH

# download indexes each epoch
for EPOCH in $(seq $START_EPOCH $END_EPOCH); do

    echo "Downloading gsfa at epoch $EPOCH"

    # get cid
    EPOCH_CID=$(curl -fs https://files.old-faithful.net/$EPOCH/epoch-$EPOCH.cid)
    if [ $? -ne 0 ]; then
        echo "Failed to get cid at epoch $EPOCH"
        exit 1
    fi

    # download gsfa
    wget -P $OUTDIR https://files.old-faithful.net/${EPOCH}/epoch-${EPOCH}-gsfa.index.tar.bz2

    if [ $? -ne 0 ]; then
        echo "Failed to download gsfa at epoch $EPOCH"
        exit 1
    fi

    bzip2 -d $OUTDIR/epoch-${EPOCH}-gsfa.index.tar.bz2
    tar -xf $OUTDIR/epoch-${EPOCH}-gsfa.index.tar

    # move to indexes folder
    mv $OUTDIR/storage/car/${EPOCH}/epoch-${EPOCH}.car-$EPOCH_CID-gsfa-index $INDEX_PATH/

done
