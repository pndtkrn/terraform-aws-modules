variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "ingress_rules" {
  type = set(object({
    cidr_ipv4   = string
    ip_protocol = string
    from_port   = number
    to_port     = number
    name        = string
  }))
}

variable "egress_rules" {
  type = set(object({
    cidr_ipv4   = string
    ip_protocol = string
    from_port   = number
    to_port     = number
    name        = string
  }))
}