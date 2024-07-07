variable "vpc_availability_zones" {
  description = "Availability zone for the VPC"
  type        = list(string)
  default     = ["eu-north-1a","eu-north-1b","eu-north-1c"]
}