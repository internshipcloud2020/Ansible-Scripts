#Provider_resources.tf:

provider "aws" {
	region = "${var.aws_region}"
}
resource "aws_vpc" "default" {
	cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "default"{
	vpc_id = "${aws_vpc.default.id}"
}
resource "aws_route" "internet_access" {
	route_table_id = "${aws_vpc.default.main_route_table_id}"
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.default.id}"
}
resource "aws_subnet" "default"{
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = "true"
}
resource aws_security_group "elb"{
	name = "terraform_example_elb"
	description = "Used in the terraform"
	vpc_id = "${aws_vpc_.default.id}"
}

ingress{
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}
egress{
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_seccurity_group" "default" {
	name = "terraform_example"
	description = "Used in the terraform"
	vpc_id = "${aws_vpc_.default.id}"
	
	ingress{
	form_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}

	ingress{
	form_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["10.0.0.0/16"]
}
egress{
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_elb" "web" {
	name = "terraform_example_elb"
	
	subnets
	security_groups
	instances
	
	listener {
		instance_port = "80"
		instance_protocol = "http"
		lb_port = "80"
		lb_protocol = "http"
	}
}
resource "aws_key"{
	key_name = "${var.key_name}"
	public_key = "${file(var_public_key_path)}
}
resource "aws_instance" "web" {
	connection{
		user = "ubuntu"
		host = "${self.public_ip}"
	}
	instance_type = "t2.micro"
	ami = "${lookup(var.aws_amis, var.aws_region)}"
	key_name = "${aws_key_pair.auth.id}"
	vpc_security_group_ids = ["${aws_security_group.default.id}"]
	subnet_id  = "${aws_subnet.default.id}"
	
	privisioner "remote-exec" {
		inline = [
			"sudo apt-get -y update", "sudo apt-get -y install nginx", "sudo service nginx start",
		]
	}
}




#output.tf:

output "address" {
	value = "${aws_elb.web.dns_name}"
}




#variables.tf:

variable "public_key_path" {
	default = "Our own generated key pair""
}
variable "key_name"{
	default = "Desired name of AWS key pairs"
}
variable "aws_region"{
	default = "us-east-1"
}
variable "aws_amis"{
	default = {
		eu-west-1 = "ami-647cbc1e"
		us-east-1 = "ami-1d4e7a66"
		us-west-1 = "ami-969ab1f6"
		us-west-2 = "ami-8803e0f0"
	}
}