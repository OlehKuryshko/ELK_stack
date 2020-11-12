resource "aws_instance" "ec2" {
  count = var.count_ec2
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.subnet_id
  root_block_device {
    volume_size = var.volume_size
    }
  tags = {
    Name = var.name
    owner = var.owner
  }
}