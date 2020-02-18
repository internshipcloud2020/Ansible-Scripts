provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
resource "aws_instance" "web1" {
   ami           = "${lookup(var.ami_id, var.region)}"
   instance_type = "t2.micro"
 }

variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "ami_id" {
  type = "map"
  default = {
    us-east-1    = "ami-xxxxxxxxxxxxxxxxx"
    eu-west-2    = "ami-xxxxxxxxxxxxxxxxx"
    eu-central-1 = "ami-xxxxxxxxxxxxxxxxx"
  }
}



#policy.tpl.txt

"version
"statement"[{
"effect": "Allow",
"action": [
"ec2:Describeinstances", "ec2:Describeimages",
"ec2:Describetags", "ec2:Describesnapshots"
],
"Resource": "${arn}"
}



#compute.tf
data "template_file" "webserver_policy_template" {
data "template_file" 



template = "${compute.tf"${path.module}/policy.tpl")}"
vars {
arn = "${aws_instance.web_server.arn}"
}




resource "aws_instance" "web-server" {
  ami           = "${lookup(var.ami_id, var.region)}"
  instance_type = "t2.micro"
  key_name      = "terraform"


  provisioner "Compute.tf" {
    source      = "eashwar.html"
    destination = "/tmp/eashwar.html"
  }
  provisioner "remote-exec" {
      inline = [
        "sudo yum install -y httpd;
        "sudo service httpd Pause";
    
      ]
    }
  connection {
    user        = "ec2-user"
    private_key = "${file("${var.private_key_path}")}"
      host = "${aws_instance.web-server.public_ip}"
  }
}



