variable "web_server_ami" {
type="map"
default={
"us-east-1"="ami-b29108ju"
"us-east-2"="ami-0iyj7279"
"us-west-1"="ami-92duc382"
"us-west-2"="ami-8nb75sl8"
}
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws-region" {
default="us-region-1"
}

provider "aws" {
access_key="${var.aws_access_key}"
secret_key="${var.aws_secret_key}"
region="${var.aws_region}"
}

resource "aws_instance" "web_server" {
ami="${var.web_server_ami}"
instance_type="t2.micro"
}

resource "aws_key_pair" "key_pair"{
key_name="${var.aws.access_key}"
public_key="${file("/home/aws_rsa.pub")}"
}

resource "aws_default_subnet" "subnet"{
available_zone="us-east-1a"
}

resource "aws_security_group" "web_security_group" {
name="w s g"
ingress {
from_port=0
to_port=22
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}
egress {
from_port=0
to_port=0
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
}

resource "aws_instance" "web_server" {
ami="${var.web_server_ami}"
instance_type="t2.micro"
subnet_id="${module.vpc.public_subnet[0]}"
}

provisioner "remote_exec" {
inline=[
chmod 600 groups
useradd g user
]
}

connection{
type="ssh"
user="ec2-user"
private-key="${file("/home/learntf/aws_rsa")}"
}

data "template_file" "example_file" {
template="$file(/path/terraform.tf)"
vars 
{
username="user"
publickey="key"
}
}

module "vpc"{
source="terraform_aws_modules/aws"
cidr="10.0.0.0/80"
private_subnet=["10.0.1.0/20","10.0.2.0/20","10.0.3.0/20"]
public_subnet=["10.0.101.0/20","10.0.102.0/20","10.0.103.0/20"]
enable_nat_gateway=true
enable_vpn_gateway=true
}



