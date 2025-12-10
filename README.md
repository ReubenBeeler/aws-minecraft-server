# AWS Minecraft Server

## About
This repo is for installing a systemd service to run a 1.21.10 minecraft server on an Amazon Linux EC2 instance. It safely starts/stops the minecraft server when launching/stopping the EC2 instance.

## Notes
* This service currently expects `/dev/xvda` (an EBS volume) for providing persistent storage when the service is stopped. When running, it uses an ephemeral copy of the server on EC2 instance store for better I/O performance. If the server is running, the server files on persistent storage will not reflect recent changes; run `$ echo $MC_PATH` to get the directory of the current server files.

## Install
To install this service, include this bash script in your EC2 instance's user data
```bash
#!/bin/bash
sudo yum install git -y \
&& git clone https://github.com/ReubenBeeler/aws-minecraft-server.git \
&& bash aws-minecraft-server/install.sh
```
