variable "aws_region" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "key_pair_path" {
    type = string
}
variable "user_data_path" {
    type = string
}
variable "asg_health_check_gc" {
    type = string
}
variable "asg_health_check_type" {
    type = string
}
variable "asg_min_size" {
    type = string
}
variable "asg_max_size" {
    type = string
}
variable "asg_desired_size" {
    type = string
}
variable "pub_subnet_1_id" {
    type = string
}
variable "iam_instance_profile_name" {
    type = string
}
variable "web_server_sg_id" {
    type = string
}
variable "lb_sg_id" {
    type = string
}
variable "pub_subnet_2_id" {
    type = string
}
variable "vpc_id" {
    type = string
}
variable "pvt_subnet_1_id" {
  type = string
}
variable "pvt_subnet_2_id" {
  type = string
}