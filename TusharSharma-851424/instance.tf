resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
 
  provisioner "execute" {
    source = "file.sh"
    destination = "/tmp/file.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/file.sh",
      "sudo /tmp/file.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PRIVATE_KEY}")}"
  }
}

resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PUBLIC_KEY}")}"
}