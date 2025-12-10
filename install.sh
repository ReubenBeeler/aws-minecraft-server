#!/bin/bash

# export EBS="/dev/xvda"
# export MC_FIFO="/tmp/minecraft-input"
# export MC_PATH="$(dirname $0)/minecraft"

# cd $(dirname $0)
cd /home/ec2-user/aws-minecraft-server

sudo dnf install java-21-amazon-corretto-headless -y

chmod 660 minecraft.service
chmod 760 minecraft-StartPre.sh minecraft-StopPost.sh

sudo ln minecraft.service /etc/systemd/system/minecraft.service
sudo ln minecraft-StartPre.sh /usr/local/bin/minecraft-StartPre.sh
sudo ln minecraft-StopPost.sh /usr/local/bin/minecraft-StopPost.sh

sudo systemctl daemon-reload

# minecraft.service will be started on boot with systemd