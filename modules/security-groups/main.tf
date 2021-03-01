#================ Web Security Group ================
resource "aws_security_group" "web_server_sg" {
  vpc_id = "${var.vpc_id}"
  name = "web_server_sg"
  description = "Web Server Security Group"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.lb_sg.id}"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#================ Load Balancer Security Group ================
resource "aws_security_group" "lb_sg" {
  vpc_id = "${var.vpc_id}"
  name = "lb_sg"
  description = "ALB Security Group"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
