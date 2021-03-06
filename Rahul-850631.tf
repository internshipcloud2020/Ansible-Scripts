#Create a template for running a simple two-tier architecture on amazon web services.
#The premise is that you have stateless app servers running behind an ELB serving traffic.


variable "aws_access_key"{}
variable "aws_secret_key"{}
variable "aws_region"{
	default="us-east-1"
}


provider "aws" {
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
region = “${var.aws_region}”
}

resource "aws_instance" "mywebserver" {
ami = "ami-b374d5a5"
instance_type = "t2.micro"
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}


#vpc
resource "aws_vpc" "default"{
	cidr_block="10.0.0.1"	
	
}

resource "aws_gateway" "mygateway"{

	vpc_id="${aws_vpc.mygateway.id}"
}

resource "aws_elb" "myelb"{

}

provisioner "remote-exec" {
    
  }
