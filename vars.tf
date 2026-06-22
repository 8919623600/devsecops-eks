variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "env" {
  description = "The environment for the EKS cluster"
  type        = string
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.35"
}

variable "subnet_ids" {
  description = "The subnet IDs for the EKS cluster"
  type        = list(string)
}