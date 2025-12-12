# AWS Minecraft Server

## About
This repo is for installing a systemd service to run a 1.21.10 Minecraft server (Java Edition) on an Amazon Linux EC2 instance. The server automatically starts when launching the EC2 instance and shuts down (with a 15 second warning) when stopping the instance.

THIS ASSUMES AN INSTANCE STORE PARTITION AT `/dev/nvme1n1`! Using an ec2 instance with instance storage (like instance family r6gd) allows better performance on IO limited tasks such as exploring new minecraft chunks. This service automatically saves and backs up the minecraft server and world files to the root filesystem, which is assumed to be a persistent EBS volume.

## Install
For a quick install, see the TL;DR subsection. For more details, see the More Details section.
### TL;DR
Run this script on your EC2.
```bash
which git >/dev/null || echo sudo yum install git -y \
&& git clone https://github.com/ReubenBeeler/aws-minecraft-server.git \
&& bash aws-minecraft-server/install.sh
```
Configure your Minecraft server, then start it with 
```bash
sudo systemctl start minecraft
```
### More Details
Make sure `git` is installed. If you're unsure if `git` is already installed, run
```bash
which git >/dev/null && echo git is installed at $(which git) || echo Need to install git
```
If you need to install `git`, you can use `yum` (or your preferred package manager) like so
```bash
sudo yum install git -y
```
When `git` is installed, you can install this service by connecting to your EC2 instance and running
```bash
git clone https://github.com/ReubenBeeler/aws-minecraft-server.git \
&& bash aws-minecraft-server/install.sh
```
The minecraft server's working directory is `/opt/aws-minecraft-server/minecraft`. By default, it will create a new world when launched using the default server properties (no whitelist, gamemode survival, difficulty easy, etc.). See the [Minecraft wiki](https://minecraft.fandom.com/wiki/Tutorials/Setting_up_a_server#Configuring_the_Minecraft_server) for details on configuring the minecraft server.

After configuring the server, you may run the server with 
```bash
sudo systemctl start minecraft
```
In the future, the server will start automatically when booting the EC2 instance.

When the server is running, you have two options for running server commands: (1) you can write commands to the fifo file at `/opt/aws-minecraft-server/fifo` or (2) you can use in-game chat commands. To use in-game chat commands, make sure to op yourself with
```bash
echo op your-minecraft-username > /opt/aws-minecraft-server/fifo
```

## EC2 Config

To access your minecraft server, make sure your server's TCP port is exposed. To do this,
1. Navigate to the security group that is attached to your EC2 instance. Then, create an ingress rule with the following properties.
1. Select `Custom TCP` traffic.
1. Set the port as `25565` (unless the port was modified in server.properties)
1. Set the IPv4 address to `0.0.0.0/0` if you want anyone to be able to connect, or limit access to devices on your current WiFi network by typing your public IPv4 followed by `/32` (e.g. `198.8.12.34/32`). Of course, you can allow access from any IPv4 via `0.0.0.0/0` and create a whitelist for only the minecraft users that should have access, but you run the unlikely risk of a malicious actor getting access to your EC2 if the server has a security vulnerability, especially if the server is an outdated version.

To join your minecraft server from your minecraft client, go to Direct Connect. Then, find the public IPv4 address of your EC2 instance and the server's TCP port you just exposed, and type them into Direct Connect using the format `ip:port` (e.g. `52.8.12.34:25565`).

Note that your EC2 instance's IP address will change every time you stop and start it. If you want the IP to be the same every time you launch the server, consider using an AWS Elastic IP (EIP) and attaching it to your EC2 instance for an extra few bucks a month (about $3.60 for me at the time of writing). I use an EIP because I frequently stop/start the EC2 so that it's only running when someone is playing (to save money).