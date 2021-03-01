#================ VPC ================
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"  
  enable_dns_hostnames = true
}

#================ IGW ================
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

#================ Public Subnet ================
resource "aws_subnet" "pub_subnet_1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "pub_subnet_2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = "true"
}

#================ Private Subnet ================
resource "aws_subnet" "pvt_subnet_1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "${var.aws_region}a"
}

resource "aws_subnet" "pvt_subnet_2" {
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "false"
  availability_zone = "${var.aws_region}b"
  cidr_block = "10.0.4.0/24"
}

#================ Public Route Table ================
resource "aws_route_table" "pub_rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

#================ EIP ================
resource "aws_eip" "nat_ip" {
  vpc = "true"
}

#================ NAT Gateway ================
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat_ip.id}"
  subnet_id = "${aws_subnet.pub_subnet_1.id}"
}

#================ Private Route Table ================
resource "aws_default_route_table" "pvt_rtb" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}" #Optional
  }
}

#================ Route Table Association ================
resource "aws_route_table_association" "pub_rtb_assoc_1" {
  subnet_id = "${aws_subnet.pub_subnet_1.id}"
  route_table_id = "${aws_route_table.pub_rtb.id}"
}

resource "aws_route_table_association" "pub_rtb_assoc_2" {
  subnet_id = "${aws_subnet.pub_subnet_2.id}"
  route_table_id = "${aws_route_table.pub_rtb.id}"
}

resource "aws_route_table_association" "pvt_rtb_assoc_1" {
  subnet_id = "${aws_subnet.pvt_subnet_1.id}"
  route_table_id = "${aws_default_route_table.pvt_rtb.id}"
}

resource "aws_route_table_association" "pvt_rtb_assoc_2" {
  subnet_id = "${aws_subnet.pvt_subnet_2.id}"
  route_table_id = "${aws_default_route_table.pvt_rtb.id}"
}

#================ NACL ================
resource "aws_network_acl" "pub_nacl" {
  vpc_id = "${aws_vpc.vpc.id}"
  subnet_ids = ["${aws_subnet.pub_subnet_1.id}", "${aws_subnet.pub_subnet_2.id}"]

  #HTTP Port
  ingress {
    rule_no = 100
    action = "allow"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #HTTPS Port
  ingress {
    rule_no = 200
    action = "allow"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #Ephemeral Ports
  ingress {
    rule_no = 300
    action = "allow"
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }

  #HTTP Port
  egress {
    rule_no = 100
    action = "allow"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #HTTPS Port
  egress {
    rule_no = 200
    action = "allow"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #Ephemeral Port
  egress {
    rule_no = 300
    action = "allow"
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_default_network_acl" "pvt_nacl" {
  default_network_acl_id = "${aws_vpc.vpc.default_network_acl_id}"

  ingress {
    rule_no = 100
    action = "allow"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = "${aws_vpc.vpc.cidr_block}"
  }

  ingress {
    rule_no = 200
    action = "allow"
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no = 100
    action = "allow"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = "${aws_vpc.vpc.cidr_block}"
  }

  egress {
    rule_no = 200
    action = "allow"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no = 300
    action = "allow"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
}
