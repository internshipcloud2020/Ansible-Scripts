 
 variable "access_key" {}
 variable "secret_key" {}
 variable "region" {
     default = " ap-south-1"
 }
 
 variable "aws_amis" {
     type = "map"
 }
 
 aws_amis {
     "ap-south-1" = "1234"
     "eu-east-1" = "5678"
     "ap-north-1" = "910112"
 }

provisioner "aws" {
    access_key= "${var.access_key}"
    secret_key= "${var.secret_key}"
    region= "${var.region}" 
}
resource "aws_instance" "web-server" {
    ami= "${lookup(var.aws_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_default_subnet.aws_subnet.id}
    depends-on = "[amazon_s3_bucket.local_bins]"
    aws_key_pair = "${aws_key_pair.key_pair_id}"
    provisioner "remote-exec"{
        script={

        }
        connection{
            type=ssh
            value = "${aws_instance_elb.loadbalancig}
        }
    }
}
resource "aws_s3_bucket" " local_bins" {
    #default = "terraform" 
    acl = "public - read"
}
resource "aws_default_subnet" " aws_subnet" {
    availability_zone = " ${var.region} "
}
output " subnet url" {
     value="${aws_default_subnet.aws_subnet.renderred}"
}
resource " aws_instance_elb" "loadbalancing" {
    ingress{
        from_port=0
        to_port=0
        protocal="tcp"
        cidr_block="[0.0.0./0]"
    }
    ingress{
        from_port=0
        to_port=80
        protocal = "https"
        cidr_block = "[0.0.0.0/0]"
    }
    egress{
        from_port=0
        to_port=0
        protocal=""
        cidr_block=""
    }
}

resource "aws_key_pair" " key_pair_id " {
key_name = "bootstrap"
value = "${path/arn.pub}"
}
#save the file as policy.tpl
resource " aws_template_file" "" {
    "version " = "" 
    "statement " = "" 
    "affect" = " "
    resource = "${arn}"
}





