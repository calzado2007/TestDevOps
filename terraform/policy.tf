resource "aws_autoscaling_policy" "project_devops" {
  name                   = "project_devops-policy"
  policy_type           = "SimpleScaling"
  resource_id           = aws_autoscaling_group.project_devops.id
  adjustment_type       = "ChangeInCapacity"
  scaling_adjustment    = 1
  cooldown              = 300
}
