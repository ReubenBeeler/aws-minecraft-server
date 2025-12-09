#!/bin/bash

export EBS="/dev/xvda"
export MC_FIFO="/tmp/minecraft-input"
export MC_PATH="$(dirname $0)/minecraft"

sudo dnf install java-21-amazon-corretto-headless

chmod 660 minecraft.service
chmod 760 minecraft-StartPre.sh minecraft-StopPost.sh

ln minecraft.service /etc/systemd/system/minecraft.service
ln minecraft-StartPre.sh /usr/local/bin/minecraft-StartPre.sh
ln minecraft-StopPost.sh /usr/local/bin/minecraft-StopPost.sh

# minecraft.service will be started on boot with systemd