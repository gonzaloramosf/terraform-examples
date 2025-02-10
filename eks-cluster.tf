module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name = "liftoff-eks-cluster"
  cluster_version = "1.32"

  subnet_ids = module.liftoff-vpc.private_subnets
  vpc_id = module.liftoff-vpc.vpc_id

  tags = {
    environment = "development"
    application = "liftoff"
  }

  eks_managed_node_groups = {
    dev = {
      min_size = 1
      max_size = 3
      desired_size = 3

      instance_types = ["t3.small"]
    }
  }
}
