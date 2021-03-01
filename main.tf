module "vpc" {
  source = "./modules/vpc"

  aws_region = "${var.aws_region}"
}

module "iam" {
  source = "./modules/iam"
}

module "security-group" {
  source = "./modules/security-groups"

  vpc_id = "${module.vpc.out_vpc_id}"
  aws_region = "${var.aws_region}"
  vpc_cidr_block = "${module.vpc.out_vpc_cidr_block}"
}

module "instance" {
  source = "./modules/instance"

  vpc_id = "${module.vpc.out_vpc_id}"
  aws_region = "${var.aws_region}"
  key_pair_path = "${var.key_pair_path}"
  instance_type = "${var.instance_type}"
  pub_subnet_1_id = "${module.vpc.out_pub_subnet_1_id}"
  pvt_subnet_1_id = "${module.vpc.out_pvt_subnet_1_id}"
  pvt_subnet_2_id = "${module.vpc.out_pvt_subnet_2_id}"
  iam_instance_profile_name = "${module.iam.out_iam_instance_profile_name}"
  user_data_path = "${var.user_data_path}"
  web_server_sg_id = "${module.security-group.out_web_server_sg_id}"
  lb_sg_id = "${module.security-group.out_lb_sg_id}"
  pub_subnet_2_id = "${module.vpc.out_pub_subnet_2_id}"
  asg_max_size = "${var.asg_max_size}"
  asg_min_size = "${var.asg_min_size}"
  asg_health_check_gc = "${var.asg_health_check_gc}"
  asg_health_check_type = "${var.asg_health_check_type}"
  asg_desired_size = "${var.asg_desired_size}"
}
