module "mgmt_security_group" {
  source = "../modules/security_group"

  vpc_id      = module.vpc.vpc_id
  name        = "mgmt-sg"
  description = "Management security group allowing SSH and HTTP"

  ingress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    name        = "SSH"
    },
    {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
      name        = "HTTP"
    },
    {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
      name        = "HTTPS"
  }]

  egress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = -1
    from_port   = 0
    to_port     = 0
    name        = "All outgoing traffic"
  }]
}

module "app_security_group" {
  source = "../modules/security_group"

  vpc_id      = module.vpc.vpc_id
  name        = "app-sg"
  description = "Application security group allowing HTTP"

  ingress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port   = 80
    to_port     = 80
    name        = "HTTP"
    },
    {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
      name        = "HTTPS"
  }]

  egress_rules = []
}
