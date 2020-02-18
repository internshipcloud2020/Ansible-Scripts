provider "aws" {
    region = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
  
}


resource "aws_instance" "example" {
  ami = $(lookup(var.ami_id, var.region))
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"

  #Provisioners
    provisioner "remote-exec" {
        inline = [
            "sudo amazon-linux install nginx1.2",
            "sudo system start nginx"

                ]
    }
    connection{
        user = "aws_instance"
        host = "${aws_instance.example.id}"

    }

}




#Variables.tf

variable "region" {
  default = "us-east-1"
}

variable "access_key" {
  default = "yyyyyyyyyy"
}

variable "secret_key" {
  default = "xxxxxxxxx"
}
variable "ami_id" {
  type = "map"
  default = {
    us-east-1    = "ami-xxxxxxxxx"
    ud-west-2    = "ami-yyyyyyyyy"
    us-central-1 = "ami-zzzzzzzzz"
  }
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
  default = "ec2-example"
}


