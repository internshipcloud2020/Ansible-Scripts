
# A simple 2_tier architecture application server


#exporting the access keys to terraform console
#export TF_VAR_aws_access_key="jhqawsguifdhgquyry1"
#export TF_VAR_aws_secret_key="8u736421qgiwuytrr782qyh4398755y98678"


variable "aws_access_key" { }
variable "aws_secret_key" { }

variable "aws_region" {
    default = "us-east-1"
  
}
variable "targer_server_count" {
    default = "3"
  
}

variable "web_server_amis" {
    type = "map"
  
}
#key-value pairs for the web server amis
web_server_amis{

    "us-east-1"     =   "u32y6578iwey"

    "us-west-1"     =   "u32y6578iwey"

    "us-north-1"    =   "u32y6578iwey"

    "us-south-1"    =   "u32y6578iwey"
}

#assigning provider -aws
#will override the default region with the following command
#terraform plan -var 'aws_region = us-south-1'

provider "aws" {
    access_key  = "${var.aws_access_key}"
    secret_key  = "${var.aws_secret_key}"
    region      = "${var.aws_region}"
  
}

locals {
  user_data = <<EOF
  echo "Welcome to the simple trail application"
  EOF
}


resource "aws_security_group" "securegroup" {

    description = "to ensure the data transmission securely"
    name = "securitygroup"
    ingress{
        from_port   = 0
        to_port     = 0
        protocol    = "TCP"
        cidr_block = [0.0.0.0./0]
    }
    egress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block = [0.0.0.0/0]
    }

  
}
resource "aws_loadbalancer_policy" "loadbal" {

    private_ip=["10.0.0.1/16","10.0.0.2/16","10.0.0.3/16"]
    public_ip=["10.0.0.0/16","10.0.0.0/16","10.0.0.0/16"]  

    enable_nat_gate = true 
    enable_server_gate = true
}


resource "aws_subnet_id" "subnet_t" {
    description = "to create the subnet id"
    availability_region = "us-east-1a"
  
}

#generate ssh keys in the terraform console using the syntax
resource "aws_ssh_key" "sshkeys" {
    public_key="awqefdas"
    private_key="kjhQGF87T4R"
  
}


#creating aws ec2 instance using AMI and region

resource "aws_instance" "application_ignix" {

    ami = "${lookup(var.web_server_amis,var.aws_region)}"
    instance_type="t2.micro"
  tage = {
      name = "Simple two tier Ec2 instance"
  }
 count="${var.targer_server_count == 3 ? 3 : 0}"

 
  subnet_id = "${aws_subnet_id.subnet_t.id}"

  depends_on = "${aws_security_group.securegroup.id}"

  output "application_server_ips"{
     value="${aws_instance.application.*.Public_ip}"
  }
 

  output "security_group_id" {
      value = "${aws_security_group.securegroup.id}"
  }

  output "subnetid" {
      value = "${aws_subnet_id.subnet_t.id}"
  }

provisioner "file" {
    source       = "desktop/folder/path"
    destination  =  ".tmp/lab/filename"
}

#creating provisioner for remote location access
provisioner "remote-loc" {


    inline=[
        "sudo yum install ignix",
        "sudo yum install required plugins",
        "sudo run or execute the apps"
    ]

    #we can run script with shellscript file also
    inline = [
        "chmod +x filename.sh",
        "./filename.sh"
    ]

    connection{
        type="ssh"
        user="pavan"
        private_key = "${file("tmp/user/path/filename")}"
    }

    #provisioning the file to web server
provisioner "file"{

        source       = "./tmp/user/filename"
        destination  = "var/www/html/filename"
    }
}


}
  

  # after completion of typing code just run terraform fmt in console to check or reassign the correct format according to hcl script
  # then execute terraform plan
  # the execute terraform apply 
  # last destroy with terraform destroy




