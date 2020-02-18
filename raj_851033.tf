#this will have the provider and we are using asw so we will have aws provider ...and save this file as providers.tf....
provider "aws"{
    access_key="${aws_access_key}"
    screct_key="${aws_secret_key}"
    region="${aws_region}"
}

#Resource file will start from here...it will have amazone machine id and instance_type which is important...this file will be save as resources.tf... 

resource "aws_instance" "myexample" {
    ami = "${lookup(webserver_ips, aws_region)}"
    instance_type = "t2.micro"
}

output "webserver_publicip" {
  value = "${aws_instance.myexample.public_ip}"
}

resource "aws_instance" "baiston" {
    ami = "${lookup(webserver_ips, aws_region)}"
    instance_type = "t2.micro"

    count = "${var.traget_val=="dev"?0:3}"
    /*for creating baiston server we have to overwrite traget_val
    in cmd pass command line value to variable *traget_val* as
    terraform plan -var traget_val="prod"
    terraform apply -var traget_val="prod"
    this will pass the value as prod and baiston server will be created.*/
}

output baiston_ip{
    value = "${aws_instance.baiston.*.public_ip}"
    /*for only particular server public id if we need then we use indexing...
    value = "${aws_instance.baiston.*.public_ip[0]}"
    this will give you the ip of the first baiston server*/
}


#variable file will start from here...this will all the variables...this will save as variables.tf


variable "aws_access_key"{}
variable "aws_secret_key"{}

variable "aws_region" {
    default = "us-east-1"
}
variable "target_val" {
    default = "dev"
}

variable webserver_ips{
    type = "map"
}

#here our terraform.tfvars file will start where will creat key and value pair of map variables...

variable "webserver_ips" {

    "us_east_1" = "ami-1234b5a5"

    "ap_south_1" = "ami-12a4b5a5"

    "us_east_2" = "ami-12v4b5a5"

    "us_south_1" = "ami-12j4b5a5"
/*random value for region and ami given just for example*/
}

provisining "installation"{
    "source"=""
    "destination"=""
}