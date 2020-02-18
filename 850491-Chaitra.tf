variables.tf 

Declaring the variables
variable aws_access_key{}
variable aws_secret_key{}
variable aws_region{
default="us-east-1"
}

provider.tf

provider "aws"
{
aws_access_key=${var.aws_access_key}
aws_secret_key=${var.aws_secret_key}
region=${var.aws_region}
}

Creating a resource
resource "aws_eip" "elastic_load_balancers"
{
ami="" #Depends on the region
instance_type="t2.micro"

To install nginx software we use provisioners
provisioner remote_exec{
inline=[
install nginx
]
}

To specify the access key and the secret key
#In the console
terraform plan TF_VAR 'aws_access_key=access key'
terraform plan TF_VAR 'aws_secret_key=secret_key'

To generate key-pair
ssh key-gen -t rsa -b 4096 -f aws_rsa

To verify connectivity
ssh -i ../aws_instance ec2_instanceuser@(ip address)

To establish connection
connection{
type="ssh"
user="username"
private_key="$file(path)"
}

resource "aws_key_pair" "elastic_compute"
{
key_name="Keyname"
public_key="$file(path)"
}



To output the key name

output "keyname" {
value=aws_key_pair.elastic_compute.key_name
}


To get the subnet ID
resource "aws_default_subnet" "subnet_id"
{
#Implicit dependency
}

subnet_ID = "${aws_default_subnet.subnet_id.id}"


To control traffic
network.tf

resource "aws_security_group" "default" {
 name        = ""
 description = ""
 vpc_id      = "vpc_id"

}
ingress {
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
}


module "vpc"
{
source=""
name="vpc_module"
cidr="[0.0.0.0/0]"
private_subnets=[List of subnets]
public_subnets=[List of subnets]
enable_nat_gateway=true
enable_vpn_gateway=true
}

resource "tls_private_key" "two-tier" {
 algorithm = "RSA"
}

resource "aws_vpc" "default" {
cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "default" {
vpc_id = "${aws_vpc.default.id}"
}

To output a specific public_subnet
value=module.vpc.*.public_subnets[0]

Backend code

#Using S3 bucket
terraform
{
backend "s3"
{
bucket="bucket_name"
key="path to the key"
region="us-east-1"
}
}

Run terraform plan
Run terraform apply




