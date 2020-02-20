#provider.tf

provider "aws" {
 access_key = "$(var.key_cloud.access_key)"
 secret_key = "$var.key_cloud.secret_key)"
 region = “us-east-1”
} 

#compute.tf
//creating an ec2 instance// 

resource "aws_instance" "web_server"{
 ami= "$(lookup(var.webserver_amis,$var.aws_region)"
 instance_type="t2.micro"
}

#variable.tf



#resource.tf

resource "aws_security_group" "web_server_sec_group" {
name = "web server security group"

ingress {
from_port = 0
to_port = 22
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

provisioner "file" {
source = "bootstrap.sh"
destination = "/tmp/bootstrap.sh"
}
provisioner "remote-exec" {
inline = [
"chmod +x /tmp/bootstrap.sh",
"/tmp/bootstrap.sh"
]
}


webserver_amis {
 # US Northern Virginia
 "us-east-1" = "refer the aws website to enter the ami key of the region"
}



















