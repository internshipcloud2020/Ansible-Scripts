/*variables.tf*/

variable "aws_acess_key"
variable "aws_seceret_key"
variable "aws_location" {
    default="US-EAST-1"
  
}


variable "chat_server_client" {
 
  default = "map"
  data=<<EOF
  This is a simple chat application between client and server to create a server and display its ip
FOE
}




/*provider.tf*/
provider "aws" {
    aws_acess_key="${var.aws_acess_key}"
    aws_seceret_key="${var.aws_seceret_key}"
  
}
chat_server_client{
    "hi"="hello"
    "how are you"="i am good"
    "how can I help you"="can you create me a server"
    "how many do you need"="5"
    "count"="5"   
}

/*resources.tf*/
resource "aws_instance" "sample" {
    ami="${lookup(var.aws_instance.sample.aws_location)}"
    instance_type="nano.tf"

}

/*compute.tfvar*/
aws_acess_key="gdj3yjuu8964"
aws_seceret_key="abc78/rt75u097/765yt7yh/ag5tg7"


output "show_chat"{
    
}

output "show_ips" {
  value = "${var.chat_server_client.*.ip}"
}



