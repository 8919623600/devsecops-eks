resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-${var.env}-node-group"
  node_role_arn   = aws_iam_role.main.arn
  subnet_ids      = aws_eks_cluster.main.vpc_config[0].subnet_ids
  instance_types  = var.node_group_instance_types
  capacity_type   = "ON_DEMAND"

data "aws_launch_template" "existing" {
  name = var.launch_template_name
}

resource "aws_launch_template_version" "with_bootstrap" {
  launch_template_id   = data.aws_launch_template.existing.id
  version_description  = "add eks bootstrap user_data"
  # Do NOT add iam_instance_profile or instance_type here for managed node groups
  user_data = base64encode(<<-EOT
    #!/bin/bash
    set -x
    exec > >(tee /var/log/bootstrap.log | logger -t userdata -s 2>/dev/console) 2>&1
    if [ -f /etc/eks/bootstrap.sh ]; then
      /etc/eks/bootstrap.sh ${aws_eks_cluster.main.name} --kubelet-extra-args '--v=4'
    else
      echo "/etc/eks/bootstrap.sh not found on AMI" >&2
      exit 1
    fi
  EOT)
}

#   launch_template {
#     id      = data.aws_launch_template.existing.id
#     version = "$Latest"
#   }

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