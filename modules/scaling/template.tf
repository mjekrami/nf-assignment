resource "aws_launch_template" "launch_template" {
  name          = "launch_template"
  image_id      = var.image_id
  instance_type = var.instance_type
  monitoring {
    enabled = true
  }
  security_group_names = [var.instance_security_group]
}
