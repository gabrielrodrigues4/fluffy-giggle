terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
  backend "s3" {
    bucket = "pedibuckets5467567"
    key    = "livestate.tfstate"
    region = "sa-east-1"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidrblock

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = merge({
    Terraform   = "true"
    Environment = "dev"
  }, { "kubernetes.io/cluster/pedi_eks" = "shared" })

  public_subnet_tags = {
    "kubernetes.io/cluster/pedi_eks" = "shared"
    "kubernetes.io/role/elb"         = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/pedi_eks"  = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "pedi_eks"
  cluster_version = "1.29"

  enable_cluster_creator_admin_permissions = "true"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  cluster_endpoint_public_access = "true"
  eks_managed_node_groups = {
    default = {
      min_size       = 2
      max_size       = 2
      desired_size   = 2
      instance_types = ["t3.small"]
    }
  }
}
