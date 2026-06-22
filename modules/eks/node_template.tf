# resource "aws_iam_instance_profile" "node" {
#   name = "${var.cluster_name}-${var.env}-node-profile"
#   role = aws_iam_role.main.name
# }

resource "aws_launch_template" "node" {
  name_prefix   = "${var.cluster_name}-${var.env}-lt"
  image_id      = var.ami
  # do not hardcode instance_type if you want the node group to control instance types
#   iam_instance_profile {
#     name = aws_iam_instance_profile.node.name
#   }

  # simple bootstrap for EKS managed nodes - cluster name injected
  user_data = base64encode("#!/bin/bash\n/etc/eks/bootstrap.sh ${aws_eks_cluster.main.name}\n")
}