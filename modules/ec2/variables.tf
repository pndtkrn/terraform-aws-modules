variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet" {
  type = string
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "security_groups" {
  type = set(string)
  #default = []
}

variable "user_data" {
  type    = string
  default = null
}

variable "instance_name" {
  type = string
}

variable "key_name" {
  type    = string
  default = null
}