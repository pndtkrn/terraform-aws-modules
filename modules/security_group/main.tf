resource "aws_security_group" "name" {
  vpc_id = var.vpc_id
  description = var.description

  tags = {
    Name = var.name
  }
}

resource "aws_security_group_ingress_rule" "security_group_ingress_rules" {
  for_each = var.ingress_rules
  security_group_id = each.value.security_group_id
  cidr_block = each.value.cidr_block
  ip_protocol = each.value.ip_protocol
  from_port = each.value.from_port
  to_port = each.value.to_port
}

resource "aws_security_group_egress_rule" "security_group_egress_rules" {
  for_each = var.egress_rules
  security_group_id = each.value.security_group_id
  cidr_block = each.value.cidr_block
  ip_protocol = each.value.ip_protocol
  from_port = each.value.from_port
  to_port = each.value.to_port
}