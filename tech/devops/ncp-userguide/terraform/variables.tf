variable "access_key" {
  description = "Naver Cloud Access Key"
  type        = string
}

variable "secret_key" {
  description = "Naver Cloud Secret Key"
  type        = string
}

variable "region" {
  description = "Region to deploy resources"
  type        = string
  default     = "KR" # 한국 리전
}

variable "site" {
  description = "Naver Cloud API Site"
  type        = string
  default     = "public"
}

variable "support_vpc" {
  description = "Whether to use VPC environment"
  type        = bool
  default     = true
}

variable "login_key_name" {
  description = "Name of the SSH login key registered in NCP"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "my_ip_block" {
  description = "My IP address block for access control"
  type        = string
}
