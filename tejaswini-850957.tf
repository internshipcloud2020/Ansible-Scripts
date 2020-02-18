#variable.tf
variable aws_access_key{
}
variable aws_secret_key{
}
variable aws_region
{
    default="u-east-1"
}
variable "name" {
  type="map"
}


#provisioner.tf
provisioner "aws"
{
access_key="$(var.aws_access_key)"
secret_key="$(var.aws_secret_key)"
region="$(var.aws_region)"
}

#compute.tf
resource "aws_instance" "webserver"
{
    ami=ami-
    instance_type="t2.micro"
}
output web_server
{
    value="$(aws_instance.web_server.public_ip)"
}


data "template_file" "aws_template"
{
    template="${file(/path)}"
    temp="$$(username,$$(password))"
    vars
    {
        username=""
        password=""

    }
}
output template_file
{
value="$(template_file.aws_template.template_file)"
}

resource "new_server"
{
    default="dev"
}

resource "aws_key" "basion"
{
    ami=ami-
    instance_type="t2.micro"
    count=$(new_server=="dev"?0:10)
}

resource "aws_instances" "web_servers"
{
    count=$(aws_key.basion.*.public_ip)
}

provider "aws_security_group"
{
inline=[
    
    
]
}

output "security"
{
    value="$(aws_security.aws_security_group.security)"
}
resource "aws_traffic" "mywebserver"
{
    availibility_zone=""
}

resource "aws_key" "key_value"
{
    bucket="learn.tf"

}
resource "security_group" "security"
{
 name="aws_security_group"
}
resource "aws_instance" "webserver"
{
    ami=ami-"   "
    instance_type="t2.micro"
    key="$(aws_key.key_value.bucket_domain_name)"
}
