#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"

# Don't proceed if package already exists since that would obliterate any files that haven't been backed up!
if [[ -d $PACKAGE_DIR ]]; then
	echo "Package already exists at $PACKAGE_DIR. In order to reinstall, backup all files and then remove $PACKAGE_DIR." >&2
    exit 1
fi

echo -e "Relocating files to $PACKAGE_DIR for installation (go to $PACKAGE_DIR for future edits)"

cd $(dirname $0)

# Install dependencies
sudo dnf install java-21-amazon-corretto-headless -y

prev_dir=$PWD
cd /
sudo mv $prev_dir $PACKAGE_DIR
sudo ln -s $PACKAGE_DIR $prev_dir
unset prev_dir

find $PACKAGE_DIR -type d -exec chmod 774 {} \;
find $PACKAGE_DIR -type f -exec chmod 660 {} \;
find $PACKAGE_DIR/bin -exec chmod 760 {} \;
sudo ln -f $PACKAGE_DIR/minecraft.service /etc/systemd/system/minecraft.service
# Make group and add user to group for minecraft.service
getent group minecraft > /dev/null || sudo groupadd minecraft # add group minecraft if not exists
id -nG $USER | grep -w minecraft || sudo usermod -aG minecraft ec2-user

# Reload systemctl so it is aware of the new service
sudo systemctl daemon-reload

# minecraft.service will automatically be started on boot and stopped on shutdown
