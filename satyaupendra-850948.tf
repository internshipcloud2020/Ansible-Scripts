#2 tyre architecture
#elb
#provisioners 
#inginix
#create own ec2 key pair for the region

variable "aws_access_key" {
  default="################"
}
variable "aws_secret_key" {
    default="#######################"
  
}
variable "aws_region" {
    default="us-east-1"
  
}

variable "username" {
    default="admin"
  
}
variable "password" {
    default="*********"
}
variable "host" {
    default="10.0.0.10"
  
}
variable "aws_amis" {
    type="map"
    "us-east-1"="ami-*********"
    "us-west-1"="ami-*********"
    "us-north-1"="ami-********"
  
}

data "template_file" "web_template"{
    template="${file(path.module/plan.tpl)}"
    values="${aws_instance.aws_virtual_instance.arn}"
}

output "web_template_op"
{
    values="${data.template_file.web_template.rendered}"
}

provider "aws" {
    access_key="${var.aws_access_key}"
    secret_key="${var.aws_secret_key}"
    region="${var.aws_region}"
  
}
resource "aws_key_pair" "keys" {
 key_name="bootstrap-key"
 public_key="${file("path")}"
 key="${aws_key_pair.deploymentkeypair.key_name}" 
}

resource "aws_instance" "aws_virtual_instance" {
    ami="${lookup(var.aws_amis,var.aws_region)}"
    instance_type="t2.micro"
    provisioner "remote-exec" "ssh_provision"{
        source="/bin/my-app.conf"
        destination="/etc/my-app.conf"
        type="ssh"
        user_data{
            username = "${var.username}"
            password = "${var.password}"
            host = "${var.host}"
        }
        private_key="${file("path")}"
    }
    ingress{
        from_port="#######"
        to_port="#########"
        protocol="tcp"
        
    }
    outgress{
        from_port="##########"
        to_port="#######"
        protocol="tcp"
    }
 
}

resource "aws_elb" "aws_loadBalancer" {
    instances="${aws_instance.aws_virtual_instance.id}"

}




