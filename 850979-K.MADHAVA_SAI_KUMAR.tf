terraform{
    version="0.11.11"
}
variable "aws_access_key" {}
variable "aws_secret_key"{}
variable "aws_region"{
    type="map"
    default="ap-south-1"
}
aws_region{
    us-east-1="ami-......"
    us-west-1="ami-......"
    ap-south-1="ami-......"
    ap-west-1="ami-......"

}
variable "pair" {
    type="map"
    default{
        "$(var.key_values)"="$(var.pairs)"
    }
}
key_values{
    default=" "
}
pairs{
    default=" "
}



provider "aws" {
  access_key="${var.aws_access_key}"
  secret_key="${var.aws_secret_key}"
  region="${var.aws_region}"

}

resource "aws_instance" "inst" {
    ami="${lookup(var.aws_region,aws_region)}"
    instance_type="t2.micro"
    provisioner "remote-exec"{
       inline={
            command="$(aws_instance.inst.private_ip)"
    }
    }
}
data "template" "temp1" {
  value="${aws_instance.inst.temp1}"
}

connection{
    type="ssh"
    user="my_user"
    private_ip="$(aws_instance.inst.private_ip)"
}
ingress{
    from="0"
    to="22"
    cidr="[0.0.0.0/0]"
    protocol="tcp"
}
outgress{
    from="0"
    to="0"
    cidr="[10.0.0.1/16]"
}
module "vpc" {
  source = "$(path(aws_instance)/p.tpl)"
  enable_nat_gateway=true
  
  
}


