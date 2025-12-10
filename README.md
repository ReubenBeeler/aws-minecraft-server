# AWS Minecraft Server

## About
This repo is for installing a systemd service to run a 1.21.10 minecraft server on an Amazon Linux EC2 instance. It safely starts/stops the minecraft server when launching/stopping the EC2 instance.

## Install
To install this service, include this bash script in your EC2 instance's user data:
```bash
#!/bin/bash
sudo yum install git -y \
&& git clone https://github.com/ReubenBeeler/aws-minecraft-server.git \
&& bash aws-minecraft-server/install.sh
```
