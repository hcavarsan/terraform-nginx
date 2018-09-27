output "private ip" {
  value = "${aws_instance.web.private_ip}"
}

output "elastic ip" {
  value = "52.206.108.67"
}
