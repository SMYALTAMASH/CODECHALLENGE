variable "name" {
  type        = "string"
  description = "The name of the IAM role to create."
  default     = "ecs-task-execution-for-ecs-fargate"
}
