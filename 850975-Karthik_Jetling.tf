
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region  = "${var.aws_region}"
}
variable "aws_access_key" {} # access_key access from environment variables
variable "aws_secret_key" {} #secret_key access from environment variables
variable "aws_region" {
    default = "us-east-1"
  
}
variable "amivars" {
  type = "map"
}

# ami.tfvars
    amivars {
        us-west-1 = "ami-xxxxxxxx"
        ap-south-1 = "ami-xxxxxxxx"
        us-east-1 = "ami-xxxxxxxx"
        ap-west-1 = "ami-xxxxxxxx"
        uk-west-1 = "ami-xxxxxxxx"
    }


# compute.tf

resource "aws_elb" "load-balancing" { # Load balancing instance
   id = "${aws_instance.karthik_server.id}"
   vpc = "true"
  
}


resource "aws_instance"  "karthik_server" { # EC2 instance
    ami = "${lookup( var.amivars , region)}" 
    instance_type = "t2.micro"  

    provisioner "local_exec" {
        command = "echo ${aws_instance.karthik_server.public_ip} > pubic_ip.txt"
    }
    provisioner "remote_exec"{
        inline = (
            command = "${aws_instance.karthik_server.private_ip}"
            )
    
    }
}
connection {
    type = "SSH"
    user = "remote_server_user"
    private_ip = "${aws_instance.karthik_server.public_ip}"
    public_ip = "${aws_instance.karthik_server.private_ip}"
}
module "aws_vpc" {
  source = "${aws_instance.karthik_server.id}"
  
}
ingress{
    from = 0
    to =22
    cidr = [0.0.0.0/0]
}


