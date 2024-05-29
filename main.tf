module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = "nearfield_instruments"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.10.0/24"
  private_subnet_cidr = "10.0.20.0/24"

  load_balancer_type = "network" # network | application Default: network
  target_lb_port     = 8080
}

module "scaling" {
  source                    = "./modules/scaling"
  instance_type             = "t2.micro"
  image_id                  = "ami-0e2ea10a9b5a89a4b" // Noble Numbat for us-east-1
  vpc_id                    = module.vpc.vpc_id
  public_subnet_id          = module.vpc.public_subnet_id
  instance_security_group   = module.vpc.security_group
  loadbalacner_target_group = module.vpc.loadbalacner_target_group

  min_size         = 0
  max_size         = 3
  desired_capacity = 3

  // Schdeule the autoscaling in cron format
  recurrence_up   = "0 6 * * *"
  recurrence_down = "0 18 * * *"
}

module "notification" {
  source             = "./modules/notification"
  recipients         = "ekrami.devops@gmail.com;ekrami2.devops@gmail.com" // Seperated by ;
  source_email       = "devops@nearfield-instruments.com"
  report_granularity = "DAILY"
}
