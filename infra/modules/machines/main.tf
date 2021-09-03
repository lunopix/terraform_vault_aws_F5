module "vpc_module" {
  source = "../vpc"
  monIP  = var.monIP

}


resource "aws_security_group" "AUTORISER_SSH_HTTPS_POUR_MOI" {
  name        = "AUTORISER_SSH_HTTPS"
  vpc_id      = module.vpc_module.vpc_id
  description = "Autoriser SSH et HTTPS pour moi uniquement"

  dynamic "ingress" {
    for_each = var.SGrules
    content {
      description      = ingress.value["description"]
      to_port          = ingress.value["port"]
      from_port        = ingress.value["port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = [var.monIP]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = "false"

    }
  }

  egress = [
    {
      description      = "Autoriser tout trafic depuis F5 vers mon IP"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = [var.monIP]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = "false"
  }]

}


resource "aws_instance" "MyF5" {
  ami                         = data.aws_ssm_parameter.ami_f5_id.value
  subnet_id                   = module.vpc_module.PublicNetCreated
  key_name                    = "toEC2us"
  associate_public_ip_address = "true"
  instance_type               = "t3.medium"
  security_groups             = [aws_security_group.AUTORISER_SSH_HTTPS_POUR_MOI.id]
  tags = {
    Name = "MyF5LB"
  }


}