resource "aws_security_group" "firewall" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  ingress {
    from_port = var.ingress_port
    to_port   = var.ingress_port
    protocol  = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }
  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = "tcp"
    cidr_blocks = [var.egress_cidr]
  }
  tags = {
    Name = var.name
    owner = var.owner
  }
}