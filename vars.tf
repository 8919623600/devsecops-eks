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

variable "node_group_desired_size" {
  description = "The desired size of the EKS node group"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "The maximum size of the EKS node group"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "The minimum size of the EKS node group"
  type        = number
  default     = 1
}

variable "node_group_instance_types" {
  description = "The instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "ami" {
  description = "The AMI ID for the EKS node group"
  type        = string
}