#!/bin/bash

PACKAGE_DIR="/opt/aws-minecraft-server"

echo -e "Relocating files to $PACKAGE_DIR for installation (go to $PACKAGE_DIR for future edits)"

cd $(dirname $0)

# Install dependencies
sudo dnf install java-21-amazon-corretto-headless -y

if [[ -d $PACKAGE_DIR ]]; then
	rm -rf $PACKAGE_DIR
fi

prev_dir=$PWD
cd /
mv $prev_dir $PACKAGE_DIR
ln -s $PACKAGE_DIR $prev_dir
unset prev_dir

cd $PACKAGE_DIR
find . -type d -exec chmod 774 {} \;
find . -type f -exec chmod 660 {} \;
find bin -exec chmod 760 {} \;
sudo ln -f minecraft.service /etc/systemd/system/minecraft.service
# Make group and add user to group for minecraft.service
getent group minecraft > /dev/null || sudo groupadd minecraft # add group minecraft if not exists
id -nG $USER | grep -w minecraft || sudo usermod -aG minecraft ec2-user

# Reload systemctl so it is aware of the new service
sudo systemctl daemon-reload

# minecraft.service will automatically be started on boot and stopped on shutdown
