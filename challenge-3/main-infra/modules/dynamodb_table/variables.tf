variable "table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-state-locks"
}