
// VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.3.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name: "test-task-vpc"
  }
}

resource "aws_subnet" "subnet-a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.3.0.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name: "test-task-subnet-a"
  }
}
resource "aws_subnet" "subnet-b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.3.3.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name: "test-task-subnet-b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "test-task-igw"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }
  lifecycle {create_before_destroy = true}
  tags = {
    Name = "test-task-route-table"
  }
}

resource "aws_route_table_association" "subnet-a-to-public" {
  subnet_id = aws_subnet.subnet-a.id
  route_table_id = aws_route_table.route-table.id
}
resource "aws_route_table_association" "subnet-b-to-public" {
  subnet_id = aws_subnet.subnet-b.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "ec2-sg" {
  name = "test-task-ec2-sg"
  description = "sg for EC2"
  vpc_id = aws_vpc.vpc.id

  ingress { # ssh
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["${var.my_ip}/32"]
  }
  ingress { #HTTP
    from_port = 8080
    protocol = "TCP"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #HTTP
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { #HTTPS
    from_port = 443
    protocol = "TCP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { # DNS
    from_port = 53
    protocol = "UDP"
    to_port = 53
  }
}

# EC2 Instance
resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = var.ec2-public-key
}
resource "aws_instance" "ec2_instance" {
  depends_on = [aws_key_pair.my-key]
  ami           = "ami-046c2381f11878233" #Ubuntu Server 24.04 LTS
  instance_type = var.ec2-type
  key_name      = aws_key_pair.my-key.key_name
  vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]
  subnet_id = aws_subnet.subnet-a.id
  associate_public_ip_address = true


  tags = {
    Name = "test-task-ec2"
  }
}

output "ec2-public-ip" {
  value = aws_instance.ec2_instance.public_ip

}