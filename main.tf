module "eks" {
  source = "./modules/eks"
  cluster_name               = var.cluster_name
  env                        = var.env
  eks_version                = var.eks_version
  subnet_ids                 = var.subnet_ids
  node_group_desired_size    = var.node_group_desired_size
  node_group_max_size        = var.node_group_max_size
  node_group_min_size        = var.node_group_min_size
  # node_group_instance_types  = var.node_group_instance_types
  ami                        = var.ami
  max_unavailable_nodes      = var.max_unavailable_nodes

}