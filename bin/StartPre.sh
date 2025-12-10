#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"
FIFO_PATH="$PACKAGE_DIR/fifo"

if [[ ! -p $FIFO_PATH ]]; then
    rm -rf $FIFO_PATH
    mkfifo -m 660 $FIFO_PATH
fi
