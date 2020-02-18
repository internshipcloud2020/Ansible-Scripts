provider "aws" {
    access_key=" "
    secret_key=" "
    region="us-east-1"
  
}


resource "aws_instance" "myapp" {
  ami="ami-"
  instance_type="t2.micro"

}
//variables.tf

variable "aws_instance" {
  access_key="${var.access_key}"
  secret_key="${var.secret_key}"
  default="us-east-1"
}



//policy.tpl

{
 "Version": "",
 "Statement": [{
 "Effect": "Allow",
 "Action": [
 "ec2:
 ],
 "Resource": "${arn}"
 ]
   }
}



data "template_file" "webserver_policy_template" {
template = "${file("${path.module}/policy.tpl")}"
vars {
arn ="${aws_instance.server.arn}
}
}