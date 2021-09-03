resource "aws_vpc" "monVPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"

}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.monVPC.id
}

resource "aws_route_table" "MyRTR" {
  vpc_id = aws_vpc.monVPC.id
  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.myigw.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""

    }
  ]
}

resource "aws_subnet" "ResourcePublicNet" {
  vpc_id                  = aws_vpc.monVPC.id
  map_public_ip_on_launch = "true"
  cidr_block              = var.PublicNet_F5.cidr
  availability_zone       = var.PublicNet_F5.Availability_zone

  tags = {
    Name = var.PublicNet_F5.Name

  }


}



resource "aws_network_acl" "myacl" {

  vpc_id = aws_vpc.monVPC.id
  ingress = [{
    action          = "ALLOW"
    cidr_block      = var.monIP
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    icmp_code       = 1
    icmp_type       = 1
    ipv6_cidr_block = ""
    rule_no         = 100

  }]

  egress = [{
    action          = "ALLOW"
    cidr_block      = var.monIP
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    icmp_code       = 1
    icmp_type       = 1
    ipv6_cidr_block = ""
    rule_no         = 100

  }]

  subnet_ids = [aws_subnet.ResourcePublicNet.id]

}

resource "aws_route_table_association" "Myassoc" {
  route_table_id = aws_route_table.MyRTR.id
  subnet_id      = aws_subnet.ResourcePublicNet.id

}