# variable's/ key values with region and ami's
variable "servers_ips"{
type = "map"

"us-east-1" = "ami-102837636"

"us-west-1" = "ami-14564dghd"

"eu-east-2" = "ami-1554fgghg"
}

#variables for keys and region
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region"{
default = "us-east-1"
}


# assigning provider,region with keys
provider "aws"{
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
region = "${var.region}"
}

# creating resource
resource "aws_instance" "test" {
ami= "${lookup(servers_ips.ami_values)}"
instance_type ="t2.micro"
}

provisining "installation"
{
"source" = ""
"destination" = ""
}







# To assign key to windows cli

set TF_VAR_aws_access_key "afdfdsfgdfdgg15431567fghg"
set TF_VAR_aws_secret_key "dgfdsfdgfasfs/43465vnvjbmnb" 