#Defining the provider
provider "aws" {
  region = "us-east-1"
}

#Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#remote state to retrieve the data
data "terraform_remote_state" "remote_config" {
  backend = "s3"
  config = {
    bucket = "clo835assignment1jatharthan"
    key    = "Networking/terraform.tfstate"
    region = "us-east-1"                  
  }
}

#Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

#Reference subnet provisioned by 01-Networking 
resource "aws_instance" "my_amazon" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.assignment1.key_name
  subnet_id                   = data.terraform_remote_state.remote_config.outputs.subnet_id
  security_groups             = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  iam_instance_profile = "LabInstanceProfile"

  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux"
    }
  )
}

#Adding SSH key to Amazon EC2
resource "aws_key_pair" "assignment1" {
  key_name   = "assignment1"
  public_key = file("${var.prefix}.pub")
}

#creating ecr
resource "aws_ecr_repository" "webappassignment1" {
  name = "webapp_assignment1"
}

resource "aws_ecr_repository" "mysqlassignment1" {
  name = "mysql_assignment1"
}