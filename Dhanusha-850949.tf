#variables
variable "aws_accesskey" { }
variable "aws_secretkey" { }
variable "aws_region" {
    default="us-east-1"
}
variable "traffic" {
  default="0"
}
variable "pair" {
  type="${map(key, value)}"
}




#Providers

provider "aws" {
  access_key="${var.aws_accesskey}"
  secret_key="${var.aws_secretkey}"
  region="${var.aws_region}"
}

#network.tf
resource "aws_default_subnetid" "default_id" {
  availability-zone = "us-east-1a"
}


#Resources

resource "aws_instance" "resource_1" {
  ami="ami-NUMBER"
  instance_type="t2-micro"
  
  file_name = "${file(enginic_app_path)}"
  subnet_id = "${aws_default_subnetid.default_id.id}"
  count="${aws_traffic.traffic_ip == "stateless"} : 2 ? 0 "
  #count ="${data.aws_webip.web_traffic.state == "1"} : 2 ? 0"
  
}

resource "aws_security_group" "traffic_ip" {
 name="security_grp"
 ingress{
   from_port=0
   to_port = 22
   protocol = "http"
   cidr_block=["0.0.0.0/0"]
 }
 egress{
   from_port=0
   to_port = 0
   protocol = -1
   cidr_block=["0.0.0.0/0"]
 }
}



#provisioner file
provisioner "remote-exec"
{
 inline=[ "sudo yum -y update" ]
}

#template
data "aws_webip" "web_traffic" {
  template="${file(enginic_app_path)}"
  template="$${user},$${pwd}"
  vars={
    "user"="user"
    "pwd"="pwd"
  }
}





