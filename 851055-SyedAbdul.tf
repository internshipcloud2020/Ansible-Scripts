provider "aws" {
  access_key = "${var.my-access-key}"
  secret_key = "${var.my-secret-key}"
  region = "${var.my-region}"
  
}

variable "my-access-key" {}

variable "my-secret-key" {}

variable "my-region" {
    default = "region-1"
}

variable "webserveramis" {
    type = "map"
}

webserveramis {

    "region-1" = "ami-1"
    "region-2" = "ami-2"
    "region-3" = "ami-3"
    "region-4" = "ami-4"
}

resource "aws_key_pair" "keys" {

    //ssh_key-gen -t rsa -b 4096 -f aws_rsa.pub
    key_name = "my-key"
    public_key = "${file("path/to/public_key")}"
  
}


resource "aws_security_groups" "security-groups" {


    ingress{

        from_port = "0"
        to_port = "80"
        protocol = "tcp"
        cidr_address = "[0.0.0.0/80]"
    }
    egress{

        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_address = "[0.0.0.0/0]"
    }
}

provisioner  "remote-exec" {
    inline =[
        "sudo install -y nginx",
        "sudo create user my-user"
    ]
} 

resource "aws_instance" "webserver" {
  
  ami = "${lookup(var.webserveramis, var.my-region)}"
  instance_type = "t2.micro"

  subnet_id = "${aws_key_pair.keys.id}"
  depends_on "$[aws_security_groups.security-groups.aws-rsa.pub]"
  
}





