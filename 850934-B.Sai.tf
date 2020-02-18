
//Create a template for running a simple two-tier architecture on Amazon Web services. The premise is that you have stateless app servers running behind an ELB serving traffic.
provider "aws" {
    region="${var.aws_regions}"
    access_key="${var.access_keys}"
    secret_key="${var.secret_keys}"
    
}
resource "aws_instance" "myec2" {
    ami=""
    instance_type="t2.micro"
    associate_public_ip_address="${aws_eip.myip.id}"
    tags{
        Name="my ec2 instance"
    }
}
variable "aws_regions" {
    default="us-east-1"
}
variable "access_keys" {}
variable "secret_keys" {}

resource "aws_key_pair" "mykey" {
    key_name="data-pair"
    public_key="${file(path.module)/fdemo.pub}"
}

provisioner "remote-exec" {
    inline =[
        "sudo install -yum nginx",
        "sudo create user ec2-user" 
        #cmds-1
        #cmds-2
    ]
}
output "mydata" {
  value = "${aws_instance.myec2.public_ip}"
}

resource "aws_eip" "myip" {
    vpn = true
}
resource "aws_security_group" "secgrp" {
    name="demosecgrp"
    ingress {
        from_port=443
        to_port=443
        protocol="tcp"
        cidr_blocks=["${aws_eip.myip.public_ip}"]
    }
    egress {
        from_port=0
        to_port=80
        protocol="tcp"
        cidr_blocks=["${aws_eip.myip.public_ip}"]
    }
}
# //template_file
data "aws_template" "mytemp" {


    //instance 
    instance="${aws_instance.myec2}"
    //provisioner
    demo_provisioner="${remote-exec}"
    //security_groups
    security="${aws_security_group.secgrp}"
    //key_pair
    key_pair="${aws_key_pair.mykey}"
}