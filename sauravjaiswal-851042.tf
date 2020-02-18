// Create a two tier architecture snf tun an instance on it
// Generate the API key where we will be getiing 
// Use the command line variable tool to export the variable to the system
/*
#--------------------------------------------------------------------------
 for bash / linux: 
    export TF_VAR_access_key=aaca786ad8as09d8as9 
    export TF_VAR_secret_key=aascasda4234sdf4534534

#--------------------------------------------------------------------------
for windwos: 
    set TF_VAR_access_key= aacggaajs32423k342c23423cc
    set TF_VAR_secret_key=asd32432jh42342k342k3
#--------------------------------------------------------------------------
 set the cloud provider for the terraform environment


    1. I will be following the linux method to create an instance and establish the connectoin between the remote and the host server
    2. To Establish the connection between them we will be using the SSH Protocol.
    3. We need to generate the ssh key for the secure connection and the command to do that is as follows:
         ssh -i keygen rsa 4096 /home/ubuntu/.ssh/fingerprint:fingerprint
    4. This will generate the public and private key for the secured communication between them.
    5. Export the public key to the command line variable
    6. export fingerprint=21asdasda34232jbasjda
*/
provider "aws" {
    profile="default"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}" 
    region="us-east"
}
//creating a new instancesn on aws 
resource "aws_instance" "ubuntu" {
  ami="ami-b34d5a5" // image of the instances
  instance_type="t2.micro"
    ssh_keys=[
      "${var.ssh.fingerprint}"
  ]
  connection{
      user="root"
      type="ssh"
      private_key="${var.secret_key}"
      timeout="2m"
  }
  ingress{
      "from"="0"
      "port"="22"
      "protocol"="tcp"  
  }
  exgress{
      "to"="0"
      "port"="-1"
      "protocol"="tcp"
  }
  provisioner "remote-exec"{
      inline=[
          "sude apt-get update -y",
          "sudo apt-get install nginx",
          "~/scripts.sh"
      ]
  }
}

