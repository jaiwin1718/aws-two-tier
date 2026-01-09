variable "project_name" {}
variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "alb_sg_id" {}
variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}
