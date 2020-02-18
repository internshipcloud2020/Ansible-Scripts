variable "aws_access_key"{}
variable "aws_secret_key"{}
variable "aws_region"
{
    default="ap-south-1"
}
variable "aws_amis"
{
    type= "map"
}
aws_amis
{
"us-east-1"="354680"
"us-west-1"="354688"
"ap-south-1"="354689"
}
variable "load"
{
    type="boolean"
    default="false"
}
provider "aws"
{
    access_key=${var.aws_access_key}
    secret_key=${var.aws_secret_key}
    region=${var.aws_region}
}
resource "aws_instance" "sateless_server"
{
ami="${lookup(var.aws_amis,var.aws_region)}"
instance_type="t2.micro"
subnet_id="${aws_default_subnet.lf_subnet_id.id}"
security_group_id="${aws_security_groups.security_groups.id}"
depends_on[aws_s3_bucket.bucket11]
depends_on[aws_loadbalancer_policy.elb1212]
connection{
type="http"
cidr_block=[10.0.0.0/0]
count={load="true"?0:2}
}
}
}
resource "aws_default_subnet" "lf_subnet_id"
{
availability_zone="us-east-1a"
}

resource "aws_s3_bucket" "bucket11"
{
acl="public-read"
}

resource "aws_security_groups" "security_groups"
{
    name="ELB seving traffic"
    
    ingress{
        from_port=0
        to_port=80
        protocol="tcp"
        cidr_block=[0.0.0.0/0]
    }
    outgress
    {
         from_port=0
        to_port=0
        protocol="-1"
        cidr_block=[0.0.0.0/0]  
    }
}
resource "aws_loadbalancer_policy" "elb1212"  
{
  depends_on[aws_security_groups.security_groups]
  depends_on[aws_s3_bucket.bucket11]
  loads="${var.load}"
  loads =="true" ? provisioner "remote-exec"
  {
      source="~/850962-Gonuguntlagnanalakshmi.tf"
      destination="~/ikj-i-/hkji-.tf"
      inline={
          " cp *.tf . *.tfvars ."
      }

  }

}
data "template_file" "name1213"
 {
     template="${file("~/jokp.tpl]")}"
    name="stateless balancing"
    arn="${var.resource.arn}"
  
}
