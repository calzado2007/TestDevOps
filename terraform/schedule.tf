resource "aws_autoscaling_schedule" "project_devops" {
  scheduled_action_name  = "project_devops-schedule"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 5
  recurrence             = "0 12 * * *"
  resource_id            = aws_autoscaling_group.project_devops.id
}