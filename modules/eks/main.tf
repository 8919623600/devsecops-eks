resource "aws_eks_cluster" "example" {
  name = "terraform_cluster"


  role_arn = aws_iam_role.cluster.arn
  version  = "1.35"

  vpc_config {
    subnet_ids = [
      "subnet-029947cb5879c3c6e",
      "subnet-03a0715609cadf2c9",
      "subnet-0e5b2e2f039a0e722",
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy,
  ]
}


