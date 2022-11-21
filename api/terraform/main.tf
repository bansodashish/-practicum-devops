terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = ">= 3.0.0"
  }
}
provider "aws" {
  region     = "cn-north-1"
  access_key = "XXX"
  secret_key = "YYY"

}

locals {
  ssh_private_key = file(var.ssh_private_key_file)
}

# data "aws_vpc" "main" {
#   filter {
#     name   = "tag:Name"
#     values = poc_vpc
#   }
# }

resource "aws_instance" "ec2" {
  ami                    = "ami-02c8191b43515df27"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.foundary.id]
  key_name               = "pe-poc-allen"

  tags = {
    Name = "foundary-test"
  }
  user_data = file("./package.sh")

}
resource "aws_security_group" "foundary" {
  name        = "foundary-sg"
  description = "Allow foundary inbound traffic"
  vpc_id      = "vpc-048e5224c4cab4fed"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for remote provisioner"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for remote provisioner"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "foundary"
  }
}

output "public_instance_ip" {
  value = aws_instance.ec2.public_ip
}