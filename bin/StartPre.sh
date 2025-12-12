#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"
FIFO_PATH="$PACKAGE_DIR/fifo"
MOUNT_POINT="/mnt/instancestore"
NVME_PARTITION="/dev/nvme1n1"

if ! mount | grep -q "$NVME_PARTITION on $MOUNT_POINT"; then
    sudo mkfs.ext4 -F $NVME_PARTITION
    sudo mkdir -p $MOUNT_POINT
    sudo mount $NVME_PARTITION $MOUNT_POINT
    sudo chmod 1777 $MOUNT_POINT
fi

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