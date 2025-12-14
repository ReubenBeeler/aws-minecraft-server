#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"
MOUNT_POINT="/mnt/instancestore"

cd $MOUNT_POINT/minecraft
tail -f $PACKAGE_DIR/fifo | /usr/bin/java -Xms6500M -Xmx6500M -jar server.jar nogui
