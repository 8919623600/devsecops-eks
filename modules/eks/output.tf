output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_arn" {
  value = aws_eks_cluster.main.arn
}

output "node_group_name" {
  value = aws_eks_node_group.main.node_group_name
}   

output "node_group_arn" {
  value = aws_eks_node_group.main.arn
}   

output "node_group_status" {
  value = aws_eks_node_group.main.status
}   

output "node_group_instance_types" {
  value = aws_eks_node_group.main.instance_types
}

output "node_group_subnet_ids" {
  value = aws_eks_node_group.main.subnet_ids
}   

output "node_group_scaling_config" {
  value = aws_eks_node_group.main.scaling_config
}




