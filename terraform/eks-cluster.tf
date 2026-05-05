module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.19.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.34"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # ✅ v21: 控制平面访问改到这里
  cluster_endpoint_public_access = true

  # ✅ 权限
  enable_cluster_creator_admin_permissions = true

  # ✅ v21: 名字变了
  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      ami_type = "AL2023_x86_64"
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      ami_type = "AL2023_x86_64"
    }
  }
}