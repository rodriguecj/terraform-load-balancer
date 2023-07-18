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

resource "aws_instance" "nest_app_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "NestAppServerInstance"
  }

  key_name = "first-microservice"

  user_data = "${file("dependencies.sh")}" 
}

output "public_ip" {
  value = aws_instance.nest_app_server.*.public_ip
}

output "private_ip" {
  value = aws_instance.nest_app_server.*.private_ip
}