#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"

cd $PACKAGE_DIR/minecraft
tail -f $PACKAGE_DIR/fifo | /usr/bin/java -Xms4G -Xmx6G -jar server.jar nogui
