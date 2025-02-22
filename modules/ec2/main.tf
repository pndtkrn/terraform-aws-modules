resource "aws_instance" "ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type

  subnet_id = var.subnet
  associate_public_ip_address = var.associate_public_ip_address

  vpc_security_group_ids = var.security_groups

  user_data = var.user_data

  key_name = var.key_name

  tags = {
    Name = "${var.instance_name}"
  }
}
