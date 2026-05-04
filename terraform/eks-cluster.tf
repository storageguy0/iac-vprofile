module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  # version = "19.19.1"
  # 升级到最新大版本
  version = "~> 21.0" 


  # cluster_name    = local.cluster_name
  # v21 中 cluster_name 简化为 name
  name               = local.cluster_name               
  # cluster_version = "1.27"
  # 使用 2026 年的主流版本
  kubernetes_version = "1.34"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # 2026 年的新标准：直接通过 Access Entry 授权创建者管理员权限
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
  #  ami_type = "AL2_x86_64"
  # 升级到 Amazon Linux 2023
    ami_type = "AL2023_x86_64" 
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}
