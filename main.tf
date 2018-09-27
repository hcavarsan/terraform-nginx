provider "aws" {
  region = "${var.aws_region}"
}


resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "consul"
  security_groups = ["${aws_security_group.default.name}"]
  
    connection {
      type        = "ssh"
      agent       = false
      user        = "ec2-user"
      private_key = "${file("consul.pem")}"
        }

  provisioner "remote-exec" {

    inline = [
      "sudo yum install -y docker",
      "sudo yum install -y git",
      "sudo systemctl start docker",
      "sudo docker run -d --name nginx -p 80:80 hcavarsan/nginx-exemplo:latest"
    ]
  }


  tags {
    Name = "nginx-example"
  }
}

 resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.web.id}"
  allocation_id = "eipalloc-050e27d30ffce4cb2"
}
  

