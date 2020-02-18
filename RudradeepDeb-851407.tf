/*
Create a template for running a simple two-tier architecture on Amazon Web services.
The premise is that you have stateless app servers running behind an ELB serving traffic.
*/


resource "aws_elb" "my-elb" {
  name = "my-elb"
  security_groups = ["${aws_security_group.elb-securitygroup.id}"]
 listener {
    instance_port = 80
    instance_protocol = "http"
  }
  tags {
    Name = "my-elb"
  }
}

resource "aws_launch_configuration" "my-launchconfig" {
  name_prefix          = "my-launchconfig"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykeypair.key_name}"
  security_groups      = ["${aws_security_group.myinstance.id}"]
}
   
resource "aws_key_pair" "mykeypair" {
  key_name = "mykeypair"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}


provider "aws" {
	region = "${var.aws_region}"
}


resource "aws_security_group" "myinstance" {
  vpc_id = "${aws_vpc.main.id}"
  name = "myinstance"
  description = "security group for my instance"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

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
      security_groups = ["${aws_security_group.elb-securitygroup.id}"]
  }

  tags {
    Name = "myinstance"
  }
}


resource "aws_security_group" "elb-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "elb"
  description = "security group for load balancer"
  egress {
      from_port = 0
      to_port = 0
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  tags {
    Name = "elb"
  }
}


resource "aws_vpc" "main" {
    cidr_block = "11.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags {
        Name = "main"
    }
}


resource "aws_subnet" "main-public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "11.0.1.0/24"
    map_public_ip_on_launch = "true"
    tags {
        Name = "main-public"
    }
}


resource "aws_subnet" "main-private" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "11.0.2.0/24"
    map_public_ip_on_launch = "false"
    tags {
        Name = "main-private"
    }
}



variable "AWS_REGION" {
  default = "us-east-1"
}


variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}


variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}


variable "AMIS" {
  type = "map"
  default = {
	#random ami
    us-east-1 = "ami-185641p"
  }
}

provisioner "remote-exec"{
      inline=[
          "sude apt-get update -y",
          "sudo apt-get install nginx",
          "~/scripts.sh"
      ]
  }
output "ELB" {
	value = "${aws_elb.my-elb.dns_name}"
}













