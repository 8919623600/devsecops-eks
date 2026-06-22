data "aws_security_group" "existing" {
  name = "Devops-learning-SG"
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-${var.env}-node-group"
  node_role_arn   = aws_iam_role.main.arn
  subnet_ids      = aws_eks_cluster.main.vpc_config[0].subnet_ids
  instance_types  = var.node_group_instance_types

  launch_template {
    id      = data.aws_launch_template.existing.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  update_config {
    max_unavailable = var.max_unavailable_nodes
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.main-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.main-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.main-AmazonEC2ContainerRegistryReadOnly,
  ]
}