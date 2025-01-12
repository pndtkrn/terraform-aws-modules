variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type = string
  default = ""
}

variable "ingress_rules" {
  type = set(object({
    security_group_id = string
    cidr_block = string
    ip_protocol = string
    from_port = number
    to_port = number
  }))
}

variable "egress_rules" {
  type = set(object({
    security_group_id = string
    cidr_block = string
    ip_protocol = string
    from_port = number
    to_port = number
  }))
}