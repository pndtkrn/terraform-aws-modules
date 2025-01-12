variable "cidr_block" {
  type = string
}

variable "name" {
  type = string
}

variable "subnets_private" {
  type = set(object({
    cidr_block        = string
    name              = string
    availability_zone = string
  }))
}

variable "subnets_public" {
  type = set(object({
    cidr_block        = string
    name              = string
    availability_zone = string
  }))
}