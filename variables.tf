variable "aws_region" {
  description = "Região da AWS a criar a Instancia"
  default     = "us-east-1"
}

# amazon linux
variable "aws_amis" {
  default = {
    "us-east-1" = "ami-04681a1dbd79675a5"
  }
}

variable "key_name" {
  description = "Nome do par de chaves"
  default = "consul"
}