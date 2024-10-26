# main.tf

provider "aws" {
  region = "us-east-1"  
}
# Fetch the latest Amazon Linux 2 AMI owned by Amazon
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# Reference the existing VPC
data "aws_vpc" "existing_vpc" {
  id = "vpc-0453264622216e9eb"  
}

# Reference the existing public subnet
data "aws_subnet" "existing_public_subnet" {
  id = "subnet-09613bb4bac99c77e" 
}

# ---------------------------
# Security Groups
# ---------------------------

# Security Group for Web Servers
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg"
  }
}

# Security Group for Application Servers
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allow HTTP traffic from Web Servers"
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]  # Allow HTTP from web_sg
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_sg"
  }
}

# ---------------------------
# EC2 Instances
# ---------------------------

# Web Servers: 4 x t2.micro
resource "aws_instance" "web_servers" {
  count                 = 4
  ami                   = data.aws_ami.amazon_linux.id
  instance_type         = "t2.micro"
  subnet_id             = data.aws_subnet.existing_public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Udacity-T2-${count.index + 1}"
  }
}

# Application Servers: 2 x m4.large
# resource "aws_instance" "app_servers" {
#   count         = 2
#  ami            = data.aws_ami.amazon_linux.id
#   instance_type = "m4.large"
#   subnet_id     = data.aws_subnet.existing_public_subnet.id
#   vpc_security_group_ids = [aws_security_group.app_sg.id]

#   tags = {
#     Name = "Udacity-M4-${count.index + 1}"
#   }
# }

