     variable.tf
variable "aws_access_key"{}
variable "aws_private_key"{}
variable "aws_region{
  default="us-east-1"
}
variable "traffic"{
 default=0
}




    provider.tf
provider "aws"
{
  access_key="${var.aws_access_key}"
  private_key="${var.aws_private_key}"
  region="${var.aws_region}"
}




    compute.tfvars
webserver_amis{
  "us-east-1"="emi-75617818"
  "us-west-1"="emi-62651899"
  "ap-south-1"="emi-356728"
}



   resource.tf
resource "aws_instance" "server"
{
  ami="${lookup("webserverver_amis","aws_region")}"
  instance_type="t2.micro"
  count= if traffic is increasing ? increse no.of servers : no need of increasing
}


/* if we need to give values explicity we have to use this commands  */
  terraform init
  terraform plan
  terraform apply -var access_key="******"
  terraform apply -var private_key="******"



if the traffic is less then we have to destroy the server we have created, in order to destroy process we need to destroy every server created at every location else the server is running until it will be destroyed then cost will be increased without any consumption
  command to destryoy
terraform destroy -var aws_region="*******"



resourse "aws_instance" "database"
{
  ami=${lookup("webserver_amis","aws_region")}
  instance_type="t2.micro"
}