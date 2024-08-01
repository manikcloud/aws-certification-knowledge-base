# Define AWS Providers for Mumbai and Singapore Regions
provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "singapore"
  region = "ap-southeast-1"
}

# VPC in Mumbai Region
resource "aws_vpc" "mumbai_vpc" {
  provider = aws.mumbai
  cidr_block = "10.0.0.0/16"  # Ensure CIDR blocks do not overlap
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "mumbai-vpc"
  }
}

# VPC in Singapore Region
resource "aws_vpc" "singapore_vpc" {
  provider = aws.singapore
  cidr_block = "10.1.0.0/16"  # Ensure CIDR blocks do not overlap
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "singapore-vpc"
  }
}

# Public Subnet in Mumbai VPC
resource "aws_subnet" "mumbai_public_subnet_1" {
  provider = aws.mumbai
  vpc_id     = aws_vpc.mumbai_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "mumbai-public-subnet-1"
  }
}

# Public Subnet in Singapore VPC
resource "aws_subnet" "singapore_public_subnet_1" {
  provider = aws.singapore
  vpc_id     = aws_vpc.singapore_vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "singapore-public-subnet-1"
  }
}

# Private Subnet in Mumbai VPC
resource "aws_subnet" "mumbai_private_subnet_1" {
  provider = aws.mumbai
  vpc_id     = aws_vpc.mumbai_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "mumbai-private-subnet-1"
  }
}

# Private Subnet in Singapore VPC
resource "aws_subnet" "singapore_private_subnet_1" {
  provider = aws.singapore
  vpc_id     = aws_vpc.singapore_vpc.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "singapore-private-subnet-1"
  }
}

# Internet Gateway for Mumbai VPC
resource "aws_internet_gateway" "mumbai_igw" {
  provider = aws.mumbai
  vpc_id = aws_vpc.mumbai_vpc.id
  tags = {
    Name = "mumbai-igw"
  }
}

# Internet Gateway for Singapore VPC
resource "aws_internet_gateway" "singapore_igw" {
  provider = aws.singapore
  vpc_id = aws_vpc.singapore_vpc.id
  tags = {
    Name = "singapore-igw"
  }
}

# Public Route Table for Mumbai VPC
resource "aws_route_table" "mumbai_public_rt" {
  provider = aws.mumbai
  vpc_id = aws_vpc.mumbai_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mumbai_igw.id
  }
  tags = {
    Name = "mumbai-public-rt"
  }
}

# Public Route Table for Singapore VPC
resource "aws_route_table" "singapore_public_rt" {
  provider = aws.singapore
  vpc_id = aws_vpc.singapore_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.singapore_igw.id
  }
  tags = {
    Name = "singapore-public-rt"
  }
}

# Associate Public Route Table with Public Subnet in Mumbai
resource "aws_route_table_association" "mumbai_public_rta" {
  provider = aws.mumbai
  subnet_id      = aws_subnet.mumbai_public_subnet_1.id
  route_table_id = aws_route_table.mumbai_public_rt.id
}

# Associate Public Route Table with Public Subnet in Singapore
resource "aws_route_table_association" "singapore_public_rta" {
  provider = aws.singapore
  subnet_id      = aws_subnet.singapore_public_subnet_1.id
  route_table_id = aws_route_table.singapore_public_rt.id
}

# EC2 Instance in Mumbai Public Subnet
resource "aws_instance" "mumbai_ec2" {
  provider                  = aws.mumbai
  ami                       = "ami-068e0f1a600cd311c"  # Example AMI ID for Mumbai region
  instance_type             = "t2.micro"
  subnet_id                 = aws_subnet.mumbai_public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "mumbai-ec2"
  }
}

# EC2 Instance in Singapore Public Subnet
resource "aws_instance" "singapore_ec2" {
  provider                  = aws.singapore
  ami                       = "ami-012c2e8e24e2ae21d"  # Example AMI ID for Singapore region
  instance_type             = "t2.micro"
  subnet_id                 = aws_subnet.singapore_public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "singapore-ec2"
  }
}

