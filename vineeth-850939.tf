provider "aws" {
    access_key="${var.aws_access_key}"
    secret_key="${var.aws_secret_key}"
    region="${aws_region}"
  
}

variable "aws_access_key" {
    value ="*****" 
}

variable "aws_secret_key" {
    value="*****"
}

variable "aws_region" {
    default="us-east-1"
}
variable "aws_webserver_amis" {
    region     ami_value
    us-east-1 = "******"
    us-west-1 = "******"
    us-east-2 = "******"

}
variable "user_name" {
    name="------" 
}

variable "user_password" {
    default="******"
}

variable "user_host" {
    default="#####"

}

provider "aws" {
    access_key="${var.aws_access_key}"
    secret_key="${var.aws_secret_key}"
    region="${aws_region}"
  
}

resource "aws_instance" "myexaple" {
   ami = "${lookup(var.webserver_amis, var.aws_region)}"
    instance_type="t2.micro"
} 


provisinor "remote.exe" "ssh_provider"{
    source_dest_check="/home/conf/app"
    destination_dest_check="/etc/terraform/app"
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("path")}"
    }
 }
        ingress {
            from_port = ****
            to_port = ****
            protocol = "tcp"
            cidr_blocks = [ip]
        }
        outgress {
            from_port = *****
            to_port = *****
            protocol = "tcp"
            cidr_block =[ip]
        }
       

}
    
}
resource "aws_key_pair" "keys" {

    public_key = "(path)"
    key_name = "${aws_key_pair.deployerkeypair.key_name}"

}

template $(path.module[]){
    vars{arn}
    arns="${aws_instance.web_server.ara}"
}




  




