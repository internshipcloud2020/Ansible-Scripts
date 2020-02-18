provider "aws"
{
    access_key="${var.aws_access_key}"
    secret_key="${var.aws_secret_key}"
    region="${var.aws_region}"
}




resource "aws_vpc" "default" {
  cidr_block="10.0.0.0/16"
}


resource "aws_subnet" default" {

vpc_id = "${aws_vpc.default.id}"
cidr_block="10.0.1.0/24"
map_public_ip_on_lunch =true


ingress {
from_port =80
to_port=80
protocol="tcp"
cidr_block=["0.0.0.0/0"]
}



egress {
from_port =0
to_port=0
protocol="-1"
cidr_block=["0.0.0.0/0"]
}

}

resource  "aws_instance" "web" {
connection {

user="ubuntu"
host="${self.public_ip}"
}
 instance_type="t2.micro"



ami="${lookup(var.aws_amis,var.aws_region)}"
subnet_id="${aws_subnet.default.id}"

provisioner "remote-exec" {
inline= [
   "sudo apt-get -y update",
"sudo apt-get -y install nginx",
"sudo service nginx start",]
}
}


resource  "aws_key_pair" "developer-keypair" {
key_name="bootstrap_key"
public_key="${file("/path/to/aws_rsa.pub")}"
}

resource "aws_instance" "web_server" {

 key_name="${aws_key_pair.developer-keypair.key_name}"
} 


"resource" " "$(arn)"

data "template_file" "webserver_policy_template" {

template="${file("${path.module}/policy.tpl")}"

vars {

  arn="${aws_instance.web_server.arn}"

}

}


output "webserver_policy_output"{
  value ="${data.template_file.webserver_policy_template.rendered}"
}

variable "aws_amis" {

  default = {

    eu-west-1 = "ami-674cbc1e"

    us-east-1 = "ami-1d4e7a66"

    us-west-1 = "ami-969ab1f6"

    us-west-2 = "ami-8803e0f0"

  }

Example: ~/.ssh/terraform.pub

DESCRIPTION

}



variable "key_name" {

  description = "Desired name of AWS key pair"

}



variable "aws_region" {

  description = "AWS region to launch servers."

  default     = "us-west-2"

}





