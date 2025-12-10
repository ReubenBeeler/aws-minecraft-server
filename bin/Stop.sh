#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"
FIFO_PATH="$PACKAGE_DIR/fifo"

echo 'say §c§lCLOSING MINECRAFT SERVER§r in §l15 seconds!' > $FIFO_PATH && sleep 12 && echo say '§l3§r...' > $FIFO_PATH && sleep 1 && echo say '§l2§r...' > $FIFO_PATH && sleep 1 && echo say '§l1§r...' > $FIFO_PATH && sleep 1
echo stop > $FIFO_PATH
