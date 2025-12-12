#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"
MOUNT_POINT="/mnt/instancestore"

cd $MOUNT_POINT/minecraft
tail -f $PACKAGE_DIR/fifo | /usr/bin/java -Xms4G -Xmx6G -jar server.jar nogui
