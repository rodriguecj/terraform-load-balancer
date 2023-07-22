terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


############### Network ################
## VCP
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "terraform_vpc"
    Tool = "Terraform"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "terraform_IG" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform_IG"
    Tool = "Terraform"
  }
}

## Sub-net 1
resource "aws_subnet" "terraform_sub_net1" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform_sub_net1"
    Tool = "Terraform"
  }
}

## Sub-net 2
resource "aws_subnet" "terraform_sub_net2" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform_sub_net2"
    Tool = "Terraform"
  }
}

## Route Table 1
resource "aws_route_table" "terraform_rt1" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_IG.id
  }

  tags = {
    Name = "terraform_rt1"
    Tool = "Terraform"
  }
}

## Route Table 2
resource "aws_route_table" "terraform_rt2" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_IG.id
  }

  tags = {
    Name = "terraform_rt2"
    Tool = "Terraform"
  }
}

## Associate route table 1
resource "aws_route_table_association" "terraform_associate_rt1" {
  subnet_id      = aws_subnet.terraform_sub_net1.id
  route_table_id = aws_route_table.terraform_rt1.id
}

## Associate route table 2
resource "aws_route_table_association" "terraform_associate_rt2" {
  subnet_id      = aws_subnet.terraform_sub_net2.id
  route_table_id = aws_route_table.terraform_rt2.id
}



# Second instance
/* resource "aws_instance" "b_nest_app_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "b_nest_app_server"
  }

  key_name = "first-microservice"

  user_data = "${file("configuration.sh")}"
} */

/* resource "aws_instance" "a_nest_app_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "a_nest_app_server"
  }

  key_name = "first-microservice"

  user_data = "${file("dependencies_b.sh")}" # configuration.sh
} */

/* output "public_ip_b_nest_app_server" {
  value = aws_instance.b_nest_app_server.*.public_ip
}

output "private_ip_b_nest_app_server" {
  value = aws_instance.b_nest_app_server.*.private_ip
} 

 output "public_ip_a_nest_app_server" {
  value = aws_instance.a_nest_app_server.*.public_ip
}

output "private_ip_c_nest_app_server" {
  value = aws_instance.a_nest_app_server.*.private_ip
} */