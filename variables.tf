# variables.tf

variable "aws_region" {
  description = "AWS region where EKS cluster will be created"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "awx-cluster"
}

variable "eks_role_arn" {
  description = "ARN of the IAM role for EKS cluster"
  type        = string
  default     = "arn:aws:iam::123456789012:role/eks-role"
}

variable "eks_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.21"
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS cluster"
  type        = list(string)
  default     = ["subnet-12345678", "subnet-23456789", "subnet-34567890"]
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "awx-node-group"
}

variable "node_role_arn" {
  description = "ARN of the IAM role for EKS node group"
  type        = string
  default     = "arn:aws:iam::123456789012:role/eks-node-role"
}

variable "instance_types" {
  description = "List of EC2 instance types for EKS node group"
  type        = list(string)
  default     = ["t3.medium", "t3.large"]
}

variable "desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 3
}

variable "awx_image" {
  description = "Docker image for AWX"
  type        = string
  default     = "ansible/awx:latest"
}
