#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"
FIFO_PATH="$PACKAGE_DIR/fifo"
MOUNT_POINT="/mnt/instancestore"

sudo rm -f $FIFO_PATH

# d1=$(sudo stat -c '%d' /)
# d2=$(sudo stat -c '%d' $MINECRAFT_DIR)
# if [[ $d1 != $d2 ]]; then
# fi
if [[ $PACKAGE_DIR/minecraft != $MOUNT_POINT/minecraft ]]; then
    # Assume minecraft dir is on faster but ephemeral storage (e.g. instance store)
    # Backup the previous minecraft dir and copy over this one
    zip backup.zip -r $PACKAGE_DIR/minecraft/
    rm -rf $PACKAGE_DIR/minecraft/
    cp -r $MOUNT_POINT/minecraft $PACKAGE_DIR/minecraft
fi