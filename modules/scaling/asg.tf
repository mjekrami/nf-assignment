resource "aws_autoscaling_group" "asg_group" {
  name                = var.asg_group_name
  min_size            = 2
  max_size            = 10
  desired_capacity    = 2
  launch_template     = aws_launch_template.launch_template.name
  vpc_zone_identifier = module.vpc.private_subnet.id
  tag {
    Name = "autoscaling_group"
  }
}
