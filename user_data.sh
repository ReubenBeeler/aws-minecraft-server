#!/bin/bash

NVME_PARTITION="/dev/nvme1n1"
MOUNT_POINT="/mnt/instancestore"

sudo mkfs.ext4 -F $NVME_PARTITION
sudo mkdir -p $MOUNT_POINT
sudo mount $NVME_PARTITION $MOUNT_POINT
sudo chmod 1777 $MOUNT_POINT