#Define the provider
provider "aws" {
  region = "us-east-1"
}

#Resource for default VPC id
resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}
#Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

#provisioning of the public subnetin the default VPC
resource "aws_subnet" "public_subnet_assignment1" {
  vpc_id            = aws_default_vpc.default_vpc.id
  cidr_block        = var.cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = merge(
    var.default_tags, {
      Name = "${var.prefix}-public-subnet"
    }
  )
}
