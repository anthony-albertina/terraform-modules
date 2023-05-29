# Create EKS resource
resource "aws_eks_cluster" "cluster" {
  name = var.name
  role_arn = aws_iam_role.cluster.arn
  version = "${var.eks_version}"

  vpc_config {
    subnet_ids = "${var.subnet_ids}" == '[""]' ? data.aws_subnets.default.ids : "${var.subnet_ids}"
  }

  # Ensure IAM role permissions are created before and deleted after the EKS cluster
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}

resource "aws_eks_node_group" "nodes" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = var.name
  node_role_arn = aws_iam_role.node_group.arn
  #subnet_ids = data.aws_subnets.default.ids
  subnet_ids = "${var.subnet_ids}" == '[""]' ? data.aws_subnets.default.ids : "${var.subnet_ids}"
  instance_types = var.instance_types

  scaling_config {
    min_size = var.min_size
    max_size = var.max_size
    desired_size = var.desired_size
  }

  # Ensure IAM role permissions are created before and deleted after the EKS Node Group
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  ]
}
