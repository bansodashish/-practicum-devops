#!/bin/bash

## Installing required tools and packages

sudo yum update -y
sudo yum install -y amazon-linux-extras
sudo yum-config-manager --enable epel
sudo yum -y install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on

##install docker-compose cli

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compos

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

 docker-compose -v
