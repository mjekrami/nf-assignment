resource "aws_security_group" "allow_incoming" {
  name   = "allow_incoming"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Allow incoming"
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    security_groups = [aws_security_group.lb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "lb" {
  name = "loadbalancer_security_group"
}
