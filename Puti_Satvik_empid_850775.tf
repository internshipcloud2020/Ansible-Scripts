#provider.tf

provider "aws" {
 access_key = "enter access key here"
 secret_key = "enter secret key here"
 region = “us-east-1”
} 

#compute.tf
//creating an ec2 instance// 

resource "aws_instance" "web_server"{
 ami= "$(lookup(var.webserver_amis,$var.aws_region)"
 instance_type="t2.micro"
}

#variable.tf

variable "aws_region" {
  default = "us-east-1"  #Select appropriate region from the list as per the AWS website
}

variable "aws_profile" {
  default = "default"
}

variable "instance_type" {
  default = "t2.micro"  #Provide appropriate instance type supported by the region
}

variable "key_pair_path" {
  default = "public-key"  
}

variable "user_data_path" {
  default = "userdata.sh" 
}

#template.tf
data "template_file" "webserver_template" {

template = "enter path of the file"
vars {
arn = "${aws_instance.web_server.arn}"
}
}

webserver_amis {
 # US Northern Virginia
 "us-east-1" = "refer the aws website to enter the ami key of the region"
}


connection {
type = "ssh"
user = "ec2-user"
private_key = "${file("path of the file")}"
}

#modules

module "instance" {

  source = "./modules/instance"
  aws_region = "${var.aws_region}"

  key_pair_path = "${var.key_pair_path}"

  instance_type = "${var.instance_type}"
  user_data_path = "${var.user_data_path}"
}
















