#!/bin/bash

# # idk why these are not being set by ./install.sh...
# EBS="/dev/xvda"
# MC_FIFO="/tmp/minecraft-input"
# MC_PATH="$(dirname $0)/minecraft"
EBS="/dev/xvda"
MC_FIFO="/tmp/minecraft-input"
MC_PATH="/home/ec2-user/aws-minecraft-server/minecraft"

cp -r $EBS/minecraft $MC_PATH

if [[ ! -p $MC_FIFO ]]; then
    mkfifo -m 660 $MC_FIFO
fi
