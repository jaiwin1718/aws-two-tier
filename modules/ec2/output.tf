output "asg_name" {
  value = aws_autoscaling_group.this.name
}
output "ec2_sg_id" {
  description = "Security group ID for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}
