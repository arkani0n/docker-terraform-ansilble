
// Variables
variable "my_ip" {
  default = "176.37.44.225"
}

variable "access_key" {
  type        = string
  description = "AWS Access Key"
  default = "" #ADD
}

variable "secret_key" {
  type        = string
  description = "AWS Secret Access Key"
  default = "" #ADD
}

variable "region" {
  default = "eu-west-2"
}

variable "ec2-public-key" {
  default = "" # ADD
}

variable "ec2-type" {
  default = "t3.micro"
}