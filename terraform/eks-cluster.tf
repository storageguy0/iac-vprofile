module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.19.0" # 锁定到报错日志中显示的当前版本

  name               = local.cluster_name
  kubernetes_version = "1.34"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # 1. 控制平面访问 (v21 依然保留了这个参数名)
  cluster_endpoint_public_access = true

  # 2. 权限管理
  enable_cluster_creator_admin_permissions = true

  # 3. 托管节点组默认配置 (确认为 managed_node_group_defaults)
  managed_node_group_defaults = {
    ami_type = "AL2023_x86_64"
  }

  managed_node_groups = {
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
