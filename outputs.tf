output "private ip site1" {
  value = "${aws_instance.web1.private_ip}"
}
output "private ip site2" {
  value = "${aws_instance.web2.private_ip}"
}

output "site1" {
  value = "${aws_eip_association.eip_site1.public_ip}"
}

output "site2" {
  value = "${aws_eip_association.eip_site2.public_ip}"
}

