#!/bin/bash

# # idk why these are not being set by ./install.sh...
# EBS="/dev/xvda"
# MC_FIFO="/tmp/minecraft-input"
# MC_PATH="$(dirname $0)/minecraft"
EBS="/dev/xvda"
MC_FIFO="/tmp/minecraft-input"
MC_PATH="/home/ec2-user/aws-minecraft-server/minecraft"

rm -f $MC_FIFO

if [[ -d $EBS/minecraft ]]; then
    zip backup.zip -r $EBS/minecraft  # auto removes previous backup.zip if exists
fi

cp -r $MC_PATH $EBS/minecraft