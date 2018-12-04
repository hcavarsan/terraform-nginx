provider "aws" {
  region = "${var.aws_region}"
}


resource "aws_instance" "web1" {
  instance_type = "t2.micro"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "monorepo"
  security_groups = ["${aws_security_group.default.name}"]
  
    connection {
      type        = "ssh"
      agent       = false
      user        = "ec2-user"
      private_key = "${file("monorepo.pem")}"
        }

  provisioner "remote-exec" {

    inline = [
      "sudo yum install -y docker",
      "sudo yum install -y git",
      "sudo systemctl start docker",
      "sudo docker run -d --name nginx-site1 -p 80:80 hcavarsan/nginx-site1:latest"
    ]
  }


  tags {
    Name = "nginx-site1"
  }
}

resource "aws_instance" "web2" {
  instance_type = "t2.micro"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "monorepo"
  security_groups = ["${aws_security_group.default.name}"]
  
    connection {
      type        = "ssh"
      agent       = false
      user        = "ec2-user"
      private_key = "${file("monorepo.pem")}"
        }

  provisioner "remote-exec" {

    inline = [
      "sudo yum install -y docker",
      "sudo yum install -y git",
      "sudo systemctl start docker",
      "sudo docker run -d --name nginx-exemplo2 -p 80:80 hcavarsan/nginx-site2:latest"
    ]
  }


  tags {
    Name = "nginx-site2"
  }
}

 resource "aws_eip_association" "eip_site1" {
  instance_id   = "${aws_instance.web1.id}"
  allocation_id = "eipalloc-0d3eed18e0223fa37"
}

 resource "aws_eip_association" "eip_site2" {
  instance_id   = "${aws_instance.web2.id}"
  allocation_id = "eipalloc-0816308fd184b9d6f"
}
  

