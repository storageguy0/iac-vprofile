module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # 1. 基础配置：v21 必须使用 name 和 kubernetes_version
  name               = local.cluster_name
  kubernetes_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # 2. 访问控制：v21 依然使用这个完整的布尔值参数
  # 严禁使用 cluster_endpoint_access 这种非标准缩写
  cluster_endpoint_public_access = true

  # 3. 权限管理
  enable_cluster_creator_admin_permissions = true

  # 4. 关键修正：v21 彻底去掉了 cluster_ 前缀
  # 原 cluster_addons 现改为 addons
  addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  # 5. 关键修正：v21 彻底去掉了 eks_ 前缀
  # 原 eks_managed_node_group_defaults 现改为 managed_node_group_defaults
  managed_node_group_defaults = {
    ami_type = "AL2023_x86_64"
  }

  # 6. 关键修正：v21 彻底去掉了 eks_ 前缀
  # 原 eks_managed_node_groups 现改为 managed_node_groups
  managed_node_groups = {
    one = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
    two = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }
}