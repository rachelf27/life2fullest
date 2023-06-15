#!/bin/bash

# Install Docker (if not already installed)
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

cd /Users/rachelmurphy/Documents/Code/life2fullest
/usr/local/bin/docker-compose up -d

