MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash

# Install Docker (if not already installed)
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

pwd > /home/ec2-user/current_dir.txt

#cd /home/ec2-user/life2fullest
#/usr/local/bin/docker-compose up -d

--==MYBOUNDARY==--
