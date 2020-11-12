output "public_ip" {
  value = aws_instance.ec2[0].public_ip
}
output "private_ip" {
  value = aws_instance.ec2[0].private_ip
}
output "name" {
  value = aws_instance.ec2[0].tags.Name
}
output "private_dns" {
  value = aws_instance.ec2[0].private_dns
}
output "public_dns" {
  value = aws_instance.ec2[0].public_dns
}
output "availability_zone" {
  value = aws_instance.ec2[0].availability_zone
}