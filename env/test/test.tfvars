cluster_name               = "robodefense-cluster"
env                        = "test"
eks_version                = "1.35"
subnet_ids                 = ["subnet-01a4e02b3d7443a83", "subnet-08640855b05a30fda", "subnet-0e5b2e2f039a0e722"]
node_group_desired_size    = 1
node_group_max_size        = 2
node_group_min_size        = 1
node_group_instance_types  = ["t3.medium"]