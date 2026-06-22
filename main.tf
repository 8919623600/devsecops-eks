module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  env          = var.env
  eks_version  = var.eks_version

}