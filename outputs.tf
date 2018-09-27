output "address" {
  value = "${aws_instance.web.private_ip}"
}

output "elastic ip" {
  value = "${aws_instance.web.public_ip}"
}