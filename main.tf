provider "aws" {
region = "us-east-1"
access_key = "AKIASMKMHFSBPPDBJ5VD"
secret_key = "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"
}


resource "aws_instance" "one" {
ami = "ami-0715c1897453cabd1"
instance_type = "t2.micro"
key_name = "tckeypair"
vpc_security_group_ids = [aws_security_group.five.id]
availability_zone = "us-east-1a"
user_data = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl restart httpd
chkconfig httpd on
echo "this is my tc practice project" > /var/www/html/index.html
EOF
tags = {
Name = "web-server1"
}
}


resource "aws_instance" "two" {
ami = "ami-0715c1897453cabd1"
instance_type = "t2.micro"
key_name = "tckeypair"
vpc_security_group_ids = [aws_security_group.five.id]
availability_zone = "us-east-1b"
user_data = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl restart httpd
chkconfig httpd on
echo "this is my tc practice project" > /var/www/html/index.html
EOF
tags = {
Name = "web-server2"
}
}


resource "aws_instance" "three" {
ami = "ami-0715c1897453cabd1"
instance_type = "t2.micro"
key_name = "tckeypair"
vpc_security_group_ids = [aws_security_group.five.id]
availability_zone = "us-east-1a"
tags = {
Name = "app-server1"
}
}
resource "aws_instance" "four" {
ami = "ami-0715c1897453cabd1"
instance_type = "t2.micro"
key_name = "tckeypair"
vpc_security_group_ids = [aws_security_group.five.id]
availability_zone = "us-east-1b"
tags = {
Name = "app-server2"
}
}

resource "aws_security_group" "five" {
name = "tc-sg"

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_s3_bucket" "six" {
bucket = "chinni08bb"
}

resource "aws_iam_user" "seven" {
for_each = var.aws_iam_users
name = each.value
}

variable "aws_iam_users"  {
type = set(string)
default = ["radha", "babbuu", "chinna"]
}
resource "aws_ebs_volume" "eight" {
 availability_zone = "us-east-1a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
