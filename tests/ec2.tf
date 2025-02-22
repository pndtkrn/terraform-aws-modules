# data "aws_ami" "amazon_linux" {
#   most_recent = true

#   filter  {
#     name = "name"
#     values = ["amzn*"]
#   }

#   filter {
#     name = "architecture"
#     values = ["x86_64"]
#   }
# }

data "aws_subnet" "public_sn_us_east_1a" {
  filter {
    name = "tag:Name"
    values = ["public_sn_us_east_1a"]
  }

  depends_on = [ module.vpc ]
}

data "aws_security_group" "mgmt-sg" {
  filter {
    name = "tag:Name"
    values = ["mgmt-sg"]
  }

  depends_on = [ module.mgmt_security_group ]
}

module "ec2" {
 source = "../modules/ec2"

 instance_name = "jenkins_master"
 ami = "ami-085ad6ae776d8f09c"
 instance_type = "t2.micro"
 subnet = data.aws_subnet.public_sn_us_east_1a.id
 associate_public_ip_address = true
 security_groups = [data.aws_security_group.mgmt-sg.id]
}
