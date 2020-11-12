data "aws_route53_zone" "selected" {
  name = var.dns_zone_name
}
resource "aws_route53_record" "dns_elk" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "elk.${data.aws_route53_zone.selected.name}"
  type = "A"
  ttl     = "300"
  records = [module.kibana.public_ip]
}

#--------------------------------create DNS local zone
resource "aws_route53_zone" "private_elk" {
  name = "stack.com."
  vpc {
    vpc_id = aws_vpc.main.id
  }
  tags = {
    Name = "stack.com."
    owner = var.owner
  }
}
#--------------------------------create DNS name local
resource "aws_route53_record" "dns_elk_cluster" {
  zone_id = aws_route53_zone.private_elk.zone_id
  name = "elk."
  type = "A"
  ttl     = "300"
  records = [
    aws_instance.elk-a.0.private_ip,
    aws_instance.elk-a.1.private_ip,
    aws_instance.elk-a.2.private_ip,
    aws_instance.elk-b.0.private_ip,
    aws_instance.elk-b.1.private_ip,
    aws_instance.elk-b.2.private_ip
  ]
  set_identifier = "dev"
  weighted_routing_policy {
    weight = 6
  }
}
#--------------------------------create DNS name local
resource "aws_route53_record" "dns_elk_logstash" {
  zone_id = aws_route53_zone.private_elk.zone_id
  name = "logstash."
  type = "A"
  ttl     = "300"
  records = [
    module.logstash-1.private_ip,
    module.logstash-2.private_ip
  ]
  set_identifier = "dev"
  weighted_routing_policy {
    weight = 2
  }
}