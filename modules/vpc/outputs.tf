output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "security_group" {
  value = aws_security_group.allow_incoming.name

}

output "loadbalacner_target_group" {
  value = aws_lb_target_group.network_loadbalancer.arn
}
