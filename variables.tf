variable "aws_region" {
  default = "us-east-1"  #Select appropriate region from the above list
}
variable "instance_type" {
  default = "t2.micro"  #Provide appropriate instance type supported by the region
}
variable "key_pair_path" {
  default = "public-key"  #Must generate your own key pair and use them to SSH
}
variable "user_data_path" {
  default = "userdata.sh" #Feel free to make changes as per requirement
}
variable "asg_health_check_gc" {
  default = "300"
}
variable "asg_health_check_type" {
  default = "ELB"
}
variable "asg_min_size" {
  default = "1" #Change the figure as per requirement
}
variable "asg_max_size" {
  default = "2" #Change the figure as per requirement
}
variable "asg_desired_size" {
  default = "1" #Change the figure as per requirement. Must be between min and max size
}
