
locals {
  my_cluster = "my-eks-${random_string.suffix.result}" 
}

resource "random_string" "suffix" {
  length = 8
  special = false
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name = local.my_cluster
  cluster_version = var.my_cluster_version
  subnet_ids = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  
   cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    }

  eks_managed_node_groups = {
    my_node_group = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t2.micro"]
      capacity_type  = "SPOT"
    }
  }

}