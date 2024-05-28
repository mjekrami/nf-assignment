module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = "nearfield_instruments"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.10.0/24"
  private_subnet_cidr = "10.0.20.0/24"
}