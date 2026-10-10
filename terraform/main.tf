
module "network" {
  source = "./modules/network"

  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
}

module "compute" {
  source = "./modules/compute"

  project_name     = var.project_name
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_ids[0]
  instance_type    = var.instance_type
  ami_id           = var.ami_id
}
