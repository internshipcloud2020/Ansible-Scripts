//provider.tf
provider "aws" {
  access_key="${var.myaws_access_key}"
  secret_key="${var.myaws_secret_key}"
  region  = "${var.aws_region}"
}

//app.tf
resource "aws_instance" "stateless_app_server" {
  ami="${lookup(var.amis,var.aws_region)}"
  instance="t2.micro"
  count=2
}
resource "aws_elb" "load_balancer" {
 //ami cant be used for create elastic load balancer
 depend_on=["${var.id_0}","${var.id_1}"]
}
provisioner "remote-exec"
{
path="${file(path.module("enginix_update.sh"))}"
inline=[ "chmod -x enginix_update.sh", "sudo /tmp/enginix.sh"]
connection{
    username="${var.username}"
    key="${var.public_key}"
}
}

data "AWS_ELB" "ELB_instance"
{
"0"="${var.public_ip_0}"
"1"="${var.public_ip_1}"
igress{
from="0"
to="0"
port=200
traffic="1"
}
egress{
from="1"
to="0"
port=200
traffic="1"
}
}
output "id_0"{
    value="${aws_instance.stateless_app_server.*.id[0]}"
} 
output "id_1"{
    value="${aws_instance.stateless_app_server.*.id[1]}"
} 
output "public_ip_0"{
    value="${aws_instance.stateless_app_server.*.public_ip[0]}"
} 
output "public_ip_1"{
    value="${aws_instance.stateless_app_server.*.public_ip[1]}"
} 
//variable.tf

variable "myaws_access_key" {}
variable "myaws_secret_key" {}
variable "aws_region" {
    type="string"
    default="us_west_1"  
}
variable "amis" {
    type="map"
    default={
        "us_west_1"="ami-bc90vhgjkjhc"
        "us_east_1"="ami-bc89vhgjkjhc"
        "us_west_2"="ami-bc97vhgjkjhc"
    }
  
}
variable "public_key"
{
default="${file(path.module("key.pub"))}"
}
variable "private_key"
{
default="${file(path.module("key"))}"
}


//enginix_update.sh
//sudo apt-get enginix update
//sudo install enginix