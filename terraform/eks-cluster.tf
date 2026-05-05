module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  # 强制使用 v21 系列，这是 2026 年的标准版本 
  version = "~> 21.0"

  # 1. 修正参数名：v20+ 使用 name 而非 cluster_name
  name               = local.cluster_name
  # 2. 修正参数名：v20+ 使用 kubernetes_version 而非 cluster_version
  kubernetes_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # 3. 修正访问控制：v20+ 将所有访问配置合并到了 cluster_endpoint_access
  cluster_endpoint_access = {
    type = "public"
  }

  # 4. 这个参数在 v20+ 才能生效
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  # 5. 修正前缀：v20+ 所有节点组参数必须带 eks_ 前缀
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  # 6. 修正前缀：同上
  eks_managed_node_groups = {
    one = {
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}