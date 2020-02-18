##provider.tf

provider "aws"{
	access_key=$(var.key_cloud.access_key)
	private_key=$(var.key_cloud.access_key)
	region=$(var.cloud_region)

}

##compute.tf

resource "aws_instance" "web_server" {
ami = "${lookup(var.webserver_amis,$var.aws_region)}"
instance_type = "t2.micro"
count=2
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


provisioner "file" {
source = "bootstrap.sh"
destination = "/tmp/bootstrap.sh"
}

resource "aws_vpc" "customvpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "customvpc"
        Terraform = true
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.customvpc.id}"

    tags = {
        Name = "igw"
        Terraform = true
    }
}




resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.customvpc.id}"
    availability_zone = "us-east-1a"
    cidr_block = "$"

    tags {
        Name = "Public Subnet"
        Terraform = true
    }
}

##variable.tf

variable "access_key" {}
variable "private_key" {}


variable "cloud_region"{
default="us-east-1"
}

##terraform.tfvars


webserver_amis {
"us-east-1" = "ami-6182g767"
"us-west-1" = "ami-3436287j"
"ap-north-1" = "ami-634fdy1"
}


##resources.tf
resource "aws_instance" "web_server" {
…
vpc_security_group_ids =
["${aws_security_group.web_server_sec_group.id}"]
}
Your web server resource should now look like the following:
resource "aws_instance" "web_server" {
ami = "${lookup(var.webserver_amis,
var.aws_region)}"
instance_type = "t2.micro"
Managing Secrets with Hashicorp Vault
Copyright 2017 Christopher Parent 29
subnet_id =
"${aws_default_subnet.learntf_default_subnet.id}"
key_name = "${aws_key_pair.deployerkeypair.
key_name}"
vpc_security_group_ids =
["${aws_security_group.web_server_sec_group.id}"]
depends_on = ["aws_s3_bucket.learntf-bins"]
}

##webservers.tf

resource "aws_security_group" "websg" {
    name = "vpc_web"
    description = ""
    vpc_id = "${aws_vpc.customvpc.id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "WebSG"
        Terraform = true
    }
}

resource "aws_instance" "web1" {
    ami = "${data.aws_ami.ubuntu.id}"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.websg.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false
   

resource "aws_eip" "web1" {
    instance = "${aws_instance.web1.id}"
    vpc = true
}



$ terraform init
$ terraform plan
$ terraform apply
$yes
$ terraform import aws_instance.web_server i-
957643he7383498

