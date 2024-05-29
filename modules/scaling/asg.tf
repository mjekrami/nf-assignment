resource "aws_autoscaling_group" "asg_group" {
  min_size            = var.max_size
  max_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = [var.vpc_id]
  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.launch_template.id
      }
    }
  }
  tag {
    key                 = "Name"
    value               = "autoscaling_group"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_schedule" "asg_schedule_up" {
  scheduled_action_name  = "schedule_up"
  desired_capacity       = var.desired_capacity
  autoscaling_group_name = aws_autoscaling_group.asg_group.name
  recurrence             = var.recurrence_up
}
resource "aws_autoscaling_schedule" "asg_schedule_down" {
  scheduled_action_name  = "schedule_down"
  desired_capacity       = var.min_size
  autoscaling_group_name = aws_autoscaling_group.asg_group.name
  recurrence             = var.recurrence_down
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg_group
  alb_target_group_arn   = var.loadbalacner_target_group

}
