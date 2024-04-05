#!/bin/bash

# Check if there is an epoch number provided
if [ $# -eq 0 ]; then
    echo "No epoch number provided"
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

if [ $START_EPOCH -gt $END_EPOCH ]; then
    echo "START_EPOCH must less than END_EPOCH"
    exit 1
fi

for EPOCH in $(seq $START_EPOCH $END_EPOCH); do
    CID=$(curl https://files.old-faithful.net/${EPOCH}/epoch-${EPOCH}.cid)
    echo "CID at EPOCH ${EPOCH}: ${CID}"

    INDEX_OFFSET_URL="https://files.old-faithful.net/${EPOCH}/epoch-${EPOCH}.car.${CID}.cid-to-offset.index"
    INDEX_SIG_EXIST_URL=https://files.old-faithful.net/${EPOCH}/epoch-${EPOCH}.car.${CID}.sig-exists.index
    INDEX_SLOT_URL=https://files.old-faithful.net/${EPOCH}/epoch-${EPOCH}.car.${CID}.slot-to-cid.index
    INDEX_SIG_URL=https://files.old-faithful.net/${EPOCH}/epoch-${EPOCH}.car.${CID}.sig-to-cid.index
    INDEX_SIGS_FOR_ADDRESS_URL=https://files.old-faithful.net/${EPOCH}/epoch-${EPOCH}.car.${CID}.gsfa.index

    LIST_INDEX=($INDEX_OFFSET_URL $INDEX_SIG_EXIST_URL $INDEX_SLOT_URL $INDEX_SIG_URL)
    for INDEX in "${LIST_INDEX[@]}"; do
        echo "INDEX: ${INDEX}"
        curl $INDEX
    done
done
