provider "aws" {
    access_key="${var.my_acess_key}"
    secret_key="${var.my_secret_key}"
    region="${lookup(var.aws_region}"
  
}
variable "my_access_key" {}
variable "my_secret_key" {}
variable "aws_region"{
    type ="map"
    aws_region{
        "us-east-1"="North Virginia"
        "us-west-1" = "LA"
        "ap-west-1" = "mumbai"
    }
}
variable "ami_ids"{
    default="bm782689"
}

variable "def_env"{
    default = "dev"
}


resource "aws_security_group" "my_security_grp"{
    ingress{
        to_port=0
        from_port=22
        protocol= "tcp"
        cidr_block= [0.0.0.0/0]
    }
    egress{
        to_port=0
        from_port=0
        protocol "-1"
        cidr_block= [0.0.0.0/0]
    }
}
resource "aws_key_pair" "my_key_pair"
{
    key_value="bootstrap_Nginix"
    private_key="${file("..\public_key")}"
}
output "key_pair"{
    private_id="${aws_key_pair.my_key_pair.id}"
}
resource "aws_subnet" "subnet"{
    name="web_Server"
}

output "subnet"{
    subnet_id="${aws_subnet.subnet}"
}

provisioner "file"{
    source= "\path\to\source"
    destination="\moving\it\to\destination"
}
provisioner "remote-exec"{
    inline=[
        "sudo yum install Nginix"
        ".\Nginix"
        "chmod -u 700 Nginix"
    ]
    connection {
        type="ssh"
        user="ec2_user"
        private_id="${file("..\private_id")}"
    }
}

provisioner "file"{
    source="hereNginix.html"
    destination="host.Nginix.html"
}

resource "aws_load_balancer_policy" "my_load_balancer"{
    to_port=0
        from_port=22
        protocol= "tcp"
        cidr_block= "0.0.0.0/0"

    
}
resource "aws_instance" "web_server" {
    ami="${var.ami_ids}"
    instance_type="t2.micro"
    region="us-east-1"
    security_id="${aws_security_group.mysecurity_grp.id}"
    key_name="${aws_key_pair.my_key_pair.key_name}"
    private_ip="${provisioner.remote_exec_private_id}"
    
    count="${var.def_env =="dev" ? 0:3}"
    domain = "${aws_subnet.subnet.domain_name}"
    }

