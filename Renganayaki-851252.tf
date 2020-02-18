#creation of aws provider
variable access_key {}
variable secret_key {}
variable aws_region{
    default="us-east-1"
}
var target_env
{
    default="application"
}
provider "aws"
{
    #run using env in terminal $export TF_VARS_access_key="somevalue"
    #run using env in terminal $export TF_VARS_secret_key="somevalue"
    access_key="${var.access_key}"
    secret_key="${var.secret_key}"
    region="${var.aws_region}"
} 
variable aws_amis
{
    type="map"
}
aws_amis{
    "us-east-1="ABC23232"
    "us-west-1="ABC23235"
    "ap-south-1="ABD23232"
    "ap=east-1="ACC23232"
}
resource "aws_instance" "webserver" {
    ami="${lookup(var.aws_amis,var.aws_region)}"
    instance_type= "t2.micro"
    count= "${var.target_env=="application"?3:0}"
}
provisioner "file"
{
    source="${"$file.module",content.sh}"
    destination="/tmp/file/home/content.sh"
}
data "template_file" "user"{
    template="$${username},$${pwd}"
    vars{
        username="root"
        pwd="123"
    }
}
provisioner "remote_exec"
{
    inline =[
        sh chmod o+rw, g+rwx "/tmp/file/home/content.sh"
        /tmp/file/home/content.sh
    ]
    connection
    {
        type="ssh"
        user="${data.template_file.user}"
        private_key="${/file/terraform/aws_rsa}"
    }
}
connection
{
    type="ssh"
    user="ec2_user"
    private_key="${/file/terraform/aws_rsa}"
}

ingress
{
    from_port="0"
    to_port="0"
    protocol="tcp"
    CIDR=[0.0.0.0/0]
}
egress
{
    from_port="80"
    to_port="21"
    protocol="tcp"
    CIDR=[0.0.0.0/0]
}

egress{
    from_port="0"
    to_port="0"
    protocol="-1"
    CIDR=[0.1.0.1/0]
}
variable static_ip_private
{
    default={
        "0"= "10.0.1.10"
        "1"="10.1.1.10"
    }
}
variable static_ip_public 
{
    default={
        "0"= "10.0.1.10"
        "1"="10.1.1.10"
    }
}
data "template_file" private_ip
{
    template="${var.static_ip_private.*.private_ip}"
}
data "template_file" public_ip
{
    template="${var.static_ip_public.*.public_ip[0]}"
}
resource "aws_instance" "webserver2"
{
    count= "${var.target_env=="application"?3:0}"
    ami="${lookup(var.aws_amis,var.aws_region),count.index}"
    instance_type= "t2.micro"   
}
resource "aws_instance" "webserver3" {
    ami="${lookup(var.aws_amis,var.aws_region)}"
    instance_type= "t2.micro"
    subnet_id="${aws_instance.subnet.id}"
    depends_on=["aws_instance.aws_s3_bucket.buckets"]
 
}
resource "aws_default_subnet" "subnet"
{
    instance="${var.subnet_ids.id}"
    availability_zone="us-east-1a"
}
resource "aws_s3_bucket" "buckets"{
    #bucket="some_name"
    acl="public_read"
}

