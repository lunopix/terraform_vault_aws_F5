variable "monIP" {
  type = string
}

variable "SGrules" {
  type = list(object({
    description = string
    protocol    = string
    port        = number

  }))

  default = [
    {
      description = "ALLOW HTTPS"
      protocol    = "tcp"
      port        = 8443

    },
    {
      description = "ALLOW SSH"
      protocol    = "tcp"
      port        = 22

    }

  ]

}