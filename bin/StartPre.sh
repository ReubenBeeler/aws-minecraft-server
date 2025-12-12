#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"
FIFO_PATH="$PACKAGE_DIR/fifo"
MOUNT_POINT="/mnt/instancestore"

if [[ ! -p $FIFO_PATH ]]; then
    sudo rm -f $FIFO_PATH
    sudo mkfifo -m 660 $FIFO_PATH
fi

if [[ $PACKAGE_DIR/minecraft != $MOUNT_POINT/minecraft ]]; then
    # Assume minecraft dir is on faster but ephemeral storage (e.g. instance store)
    # Backup the previous minecraft dir and copy over this one
    sudo rm -rf $MOUNT_POINT/minecraft
    sudo cp -r $PACKAGE_DIR/minecraft $MOUNT_POINT/minecraft
fi