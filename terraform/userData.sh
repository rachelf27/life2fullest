MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash

# Ensure all package information is up-to-date
yum update -y

# Install Docker if not already installed
amazon-linux-extras install docker -y
systemctl start docker
usermod -a -G docker ec2-user
docker -v

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Install Node.js
curl -sL https://rpm.nodesource.com/setup_14.x | bash -
yum install nodejs -y
node --version
npm --version

# Install git
yum install git -y

# Clone the repository and install dependencies
git clone https://github.com/rachelf27/life2fullest.git
cd life2fullest/
npm install @aws-sdk/client-dynamodb
npm install @aws-sdk/lib-dynamodb
npm install

# Populate initial data
node data/populateData.js || echo "Error populating data, but continuing script execution"

# Start Docker containers with Docker Compose
docker-compose up -d

--==MYBOUNDARY==--
