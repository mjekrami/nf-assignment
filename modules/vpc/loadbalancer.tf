resource "aws_lb" "loadbalancer" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.public_subnet.id]
  tags = {
    Name = "loadbalacner"
  }
}

resource "aws_lb_target_group" "network_loadbalancer" {
  port     = var.target_lb_port
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id
  depends_on = [
    aws_lb.loadbalancer
  ]
  lifecycle {
    create_before_destroy = true
  }
}
