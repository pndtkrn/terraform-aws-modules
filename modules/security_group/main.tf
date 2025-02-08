resource "aws_security_group" "security_group" {
  vpc_id = var.vpc_id
  description = var.description

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "security_group_ingress_rules" {
  for_each = {for index, rule in var.ingress_rules: "${rule.ip_protocol}-${rule.cidr_ipv4}-${rule.from_port}" => rule}
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4 = each.value.cidr_ipv4
  ip_protocol = each.value.ip_protocol
  from_port = each.value.from_port
  to_port = each.value.to_port

  tags = {
    Name = each.value.name
  }
}

resource "aws_vpc_security_group_egress_rule" "security_group_egress_rules" {
  for_each = {for index, rule in var.egress_rules: "${rule.ip_protocol}-${rule.cidr_ipv4}-${rule.from_port}" => rule}
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4 = each.value.cidr_ipv4
  ip_protocol = each.value.ip_protocol
  from_port = each.value.from_port
  to_port = each.value.to_port

  tags = {
    Name = each.value.name
  }
}