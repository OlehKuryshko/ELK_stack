module "ssh" {
  name = "allow_ssh"
  description = "allow_ssh"
  vpc_id = aws_vpc.main.id
  ingress_port = 22
  ingress_cidr = var.my_cidr
  egress_cidr = var.my_cidr
  owner = var.owner
  source = "./security"
}
module "ssh-vpc" {
  name = "allow_ssh_vpc"
  description = "allow_ssh_vpc"
  vpc_id = aws_vpc.main.id
  ingress_port = 22
  ingress_cidr = var.vpc_cidr
  egress_cidr = var.my_cidr
  owner = var.owner
  source = "./security"
}
module "web" {
  name = "allow_web"
  description = "allow_web"
  vpc_id = aws_vpc.main.id
  ingress_port = 80
  ingress_cidr = var.my_cidr
  egress_cidr = var.my_cidr
  owner = var.owner
  source = "./security"
}
module "allow_elk" {
  name = "allow_elk"
  description = "allow_elk"
  vpc_id = aws_vpc.main.id
  ingress_port = 9200
  ingress_cidr = var.vpc_cidr
  egress_cidr = var.my_cidr
  owner = var.owner
  source = "./security"
}
module "allow_elk_1" {
  name = "allow_elk_in"
  description = "allow_elk_in"
  vpc_id = aws_vpc.main.id
  ingress_port = 9300
  ingress_cidr = var.vpc_cidr
  egress_cidr = var.my_cidr
  owner = var.owner
  source = "./security"
}
module "allow_logstash" {
  name = "allow_logstash"
  description = "allow_logstash"
  vpc_id = aws_vpc.main.id
  ingress_port = 5044
  ingress_cidr = var.vpc_cidr
  egress_cidr = var.my_cidr
  owner = var.owner
  source = "./security"
}