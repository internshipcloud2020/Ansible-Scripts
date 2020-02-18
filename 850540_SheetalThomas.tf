/*create an ec2 
keyname and password must be specified via tf command

create a simple tf template that runs 2 tier architecture
stateless app
provisioners to run in remote server*/

#INITIALISING VARIABLES IN variables.tf

variable "access_key" {}

variable "secret_key" {}

variable "region" {
	default="ap-south-1"
}

variable "webserver_amis"{
	type= "map"
}

webserver_amis{

    #virginia
	"us-east-1"="ami-**********"

    #mumbai
    	"ap-south-1"="ami-**********"

     ................  #similary other web server amis are declared as key-value pair"


}

variable "count"{
default="1"
}




#SETTING UP PROVIDER in provider.tf

provider "aws"{

acess_key= "${var.access_key}"
secret_key="${var.secret_key}"
region="${var.region}"

}



#setting up key_name and password via tf command.(we can improvise the security of access_key and secret_key by opening the text in vi editor. apply terminal command "chmod 600" or any other mode of our choice that can impove security.)

$ export TF_VAR_access_key= "my_access_key"
$ export TF_VAR_secret_key= "my_secret_key"




#SETTING UP PROVISIONS

resorce "aws_instance" "web_server"{
ami = "${lookup(var.webserver_amis, var.region)}"
instance_type = "t2.micro"
type="ssh"
user="ec2_user"
private_key=${file("/path/to/find/aws_rsa")}"
}

resource "aws_instance" "mumbai" {
ami = "${lookup(var.webserver_amis, var.region)}"
instance_type = "t2.micro"
count = "${var.target_env == "dev" ? 0 : 1}"
}

resource "aws_instance" "virginia" {
ami = "${lookup(var.webserver_amis, us-east-1)}"
instance_type = "t2.micro"
}

resource "aws_default_subnet" "subnet"{
availability_zone="us-east-1"
}






$ssh-keygen -t rsa -b 3872  -f aws_rsa

# key values for ec2_instance

#keypairs.tf

resorce "aws_keypair" "deploy_keypair"
{
key_name="${var.access_key}"
public_key= "${var.secret_key}"
}



#compute.tf:

output "mumbai_ips" {
value = "${aws_instance.mumbai.*.private_ip}"
}

resource "aws_instance" "web_server"{
key_name="${aws_keypair.deploy_keypair.key_name}"
}

provisioner_remote-execution{

inline[

#installation commands
#sudo .......

]

}

#in order to allow ssh into webserver , make a seperate "network.tf" file. Mention the INGRESS and EGRESS specifications such as source port,destination port,destination etc
#network.tf
resouce "aws_security_group" "wsg"{

ingress{
from_port=0
to_port=22
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}



egress{
from_port=0
to_port=0
protocol="-1" //allows any protocols
cidr_blocks=["0.0.0.0/0"]
}
}