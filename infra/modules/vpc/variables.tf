variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "PublicNet_F5" {
  type = object({
    Name              = string
    cidr              = string
    Availability_zone = string

  })

  default = {
    Availability_zone = "us-east-1a"
    Name              = "F5_public"
    cidr              = "192.168.3.0/24"
  }

}

variable "monIP" {
  type = string

}

