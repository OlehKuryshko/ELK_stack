#-----------------------------------bastion
module "bastion" {
  ami = var.ami
  instance_type = var.instance_type
  availability_zone = var.availability_zone[0]
  key_name = var.key_name
  vpc_security_group_ids = [module.ssh.id]
  subnet_id = aws_subnet.public.0.id
  volume_size = var.volume_size
  name = "bastion"
  owner = var.owner
  source = "./instances"
}
#-----------------------------------kibana
module "kibana" {
  ami = var.ami
  instance_type = var.instance_type_max
  availability_zone = var.availability_zone[1]
  key_name = var.key_name
  vpc_security_group_ids = [module.ssh-vpc.id, module.web.id]
  subnet_id = aws_subnet.public.1.id
  volume_size = var.volume_size
  name = "kibana"
  owner = var.owner
  source = "./instances"
}
#-----------------------------------logstash instance 2 availability_zone
module "logstash-1" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [module.ssh-vpc.id, module.allow_logstash.id]
  subnet_id = aws_subnet.private.0.id
  volume_size = var.volume_size
  name = "logstash-1"
  owner = var.owner
  source = "./instances"
}
module "logstash-2" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [module.ssh-vpc.id, module.allow_logstash.id]
  subnet_id = aws_subnet.private.1.id
  volume_size = var.volume_size
  name = "logstash-2"
  owner = var.owner
  source = "./instances"
}
#-----------------------------------ELK cluster 2 availability_zone
resource "aws_instance" "elk-a" {
  count = var.elk_count
  ami               = var.ami
  instance_type     = var.instance_type_max
  availability_zone = var.availability_zone[0]
  key_name          = var.key_name
  vpc_security_group_ids = [module.ssh-vpc.id, module.allow_elk.id, module.allow_elk_1.id]
  subnet_id = aws_subnet.private.0.id
  root_block_device {
    volume_size = "10"
}
  tags = {
    Name = "elk-a-${count.index + 1}"
    owner = "okury"
  }
}
resource "aws_instance" "elk-b" {
  count = var.elk_count
  ami               = var.ami
  instance_type     = var.instance_type_max
  availability_zone = var.availability_zone[1]
  key_name          = var.key_name
  vpc_security_group_ids = [module.ssh-vpc.id, module.allow_elk.id, module.allow_elk_1.id]
  subnet_id = aws_subnet.private.1.id
  root_block_device {
    volume_size = "10"
}
  tags = {
    Name = "elk-b-${count.index + 1}"
    owner = "okury"
  }
}
