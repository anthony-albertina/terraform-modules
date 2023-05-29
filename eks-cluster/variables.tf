# EKS vars
variable "eks_version" { # https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html
  description = "The k8s version, make sure supported by aws"
  type = string
}

variable "subnet_ids" {
  description = "Optional parameter if desired in non-default subnets"
  type = list(string)
  default = [""]
}

variable "name" {
  description = "The name for EKS cluster"
  type = string
  default = "EKS-Cluster-Module"
}

variable "min_size" {
  description = "Min number of nodes in EKS cluster"
  type = number
  default = 1
}

variable "max_size" {
  description = "Max number of nodes in EKS cluster"
  type = number
  default = 2
}

variable "desired_size" {
  description = "Desired number of nodes for EKS cluster"
  type = number
  default = 1
}

variable "instance_types" {
  description = "The types of EC2 instances to run on"
  type = list(string)
  default = [ "m5a.large" ]
}
