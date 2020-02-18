provider "aws" {
access_key="${var.access_keys}"
secret_key="${var.secret_keys}"
region="${var.aws_region}"  
}
resource "ec2_instance" "twotier" {
    ami="${var.ami}"
    instance_type="t2.micro"


  
}
data "template" "my_template" {
  
      target="${ec2_instance.twotier.my_template}"
  }
  


variable "keys" {
    default=""
}

connection{
    type="ssh"
    user="user"
    ip="${ec2_instance.twotier.ip}"
}
variable "values" {}
variable "access_keys" {
default="1233545432"
}
variable "secret_keys" {
    default="124565435"
}
provisioner "remote-exec"
{
    inline{

    command="${ec2_instance.twotier.public_ip}"
    }
}
variable "keyvalue" {
    type="map"
    default{
        "${var.key}"="${var.values}"
    }
}
variable "aws_region" {
    type="map"
  
}
aws_region{
    "us-east-1"="amibc5132"
    "us-west-2"="amicsw112"
    "ap-east-1"="ami112233"
    "ap-west-1"="ami234567"
}

ingress{
    from="0"
    to="45"
    protocol="tcp"
    cidr=[" 0.0.0.0/0 "]
}
exgress{
    from="0"
    to="0"
    protocol="-1"
    cidr=["    "]
}



  






