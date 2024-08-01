provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"  # Mumbai region
}

provider "aws" {
  alias  = "singapore"
  region = "ap-southeast-1"  # Singapore region
}

# Create VPC in Mumbai
resource "aws_vpc" "mumbai_vpc" {
  provider = aws.mumbai
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "mumbai-vpc"
  }
}

# Create VPC in Singapore
resource "aws_vpc" "singapore_vpc" {
  provider = aws.singapore
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "singapore-vpc"
  }
}

# Create Public Subnets in Mumbai
resource "aws_subnet" "mumbai_public_1" {
  provider = aws.mumbai
  vpc_id     = aws_vpc.mumbai_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "mumbai-public-subnet-1"
  }
}

resource "aws_subnet" "mumbai_public_2" {
  provider = aws.mumbai
  vpc_id     = aws_vpc.mumbai_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "mumbai-public-subnet-2"
  }
}

# Create Private Subnets in Mumbai
resource "aws_subnet" "mumbai_private_1" {
  provider = aws.mumbai
  vpc_id     = aws_vpc.mumbai_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "mumbai-private-subnet-1"
  }
}

resource "aws_subnet" "mumbai_private_2" {
  provider = aws.mumbai
  vpc_id     = aws_vpc.mumbai_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "mumbai-private-subnet-2"
  }
}

# Create Public Subnets in Singapore
resource "aws_subnet" "singapore_public_1" {
  provider = aws.singapore
  vpc_id     = aws_vpc.singapore_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "singapore-public-subnet-1"
  }
}

resource "aws_subnet" "singapore_public_2" {
  provider = aws.singapore
  vpc_id     = aws_vpc.singapore_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "singapore-public-subnet-2"
  }
}

# Create Private Subnets in Singapore
resource "aws_subnet" "singapore_private_1" {
  provider = aws.singapore
  vpc_id     = aws_vpc.singapore_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "singapore-private-subnet-1"
  }
}

resource "aws_subnet" "singapore_private_2" {
  provider = aws.singapore
  vpc_id     = aws_vpc.singapore_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "singapore-private-subnet-2"
  }
}

# Create IGW for Mumbai VPC
resource "aws_internet_gateway" "mumbai_igw" {
  provider = aws.mumbai
  vpc_id = aws_vpc.mumbai_vpc.id
  tags = {
    Name = "mumbai-igw"
  }
}

# Create IGW for Singapore VPC
resource "aws_internet_gateway" "singapore_igw" {
  provider = aws.singapore
  vpc_id = aws_vpc.singapore_vpc.id
  tags = {
    Name = "singapore-igw"
  }
}

# Create Public Route Table for Mumbai VPC
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

# Create Private Route Table for Mumbai VPC
resource "aws_route_table" "mumbai_private_rt" {
  provider = aws.mumbai
  vpc_id = aws_vpc.mumbai_vpc.id
  tags = {
    Name = "mumbai-private-rt"
  }
}

# Associate Public Subnets with Public Route Table for Mumbai VPC
resource "aws_route_table_association" "mumbai_public_subnet_1" {
  provider = aws.mumbai
  subnet_id      = aws_subnet.mumbai_public_1.id
  route_table_id = aws_route_table.mumbai_public_rt.id
}

resource "aws_route_table_association" "mumbai_public_subnet_2" {
  provider = aws.mumbai
  subnet_id      = aws_subnet.mumbai_public_2.id
  route_table_id = aws_route_table.mumbai_public_rt.id
}

# Associate Private Subnets with Private Route Table for Mumbai VPC
resource "aws_route_table_association" "mumbai_private_subnet_1" {
  provider = aws.mumbai
  subnet_id      = aws_subnet.mumbai_private_1.id
  route_table_id = aws_route_table.mumbai_private_rt.id
}

resource "aws_route_table_association" "mumbai_private_subnet_2" {
  provider = aws.mumbai
  subnet_id      = aws_subnet.mumbai_private_2.id
  route_table_id = aws_route_table.mumbai_private_rt.id
}

# Create Public Route Table for Singapore VPC
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

# Create Private Route Table for Singapore VPC
resource "aws_route_table" "singapore_private_rt" {
  provider = aws.singapore
  vpc_id = aws_vpc.singapore_vpc.id
  tags = {
    Name = "singapore-private-rt"
  }
}

# Associate Public Subnets with Public Route Table for Singapore VPC
resource "aws_route_table_association" "singapore_public_subnet_1" {
  provider = aws.singapore
  subnet_id      = aws_subnet.singapore_public_1.id
  route_table_id = aws_route_table.singapore_public_rt.id
}

resource "aws_route_table_association" "singapore_public_subnet_2" {
  provider = aws.singapore
  subnet_id      = aws_subnet.singapore_public_2.id
  route_table_id = aws_route_table.singapore_public_rt.id
}

# Associate Private Subnets with Private Route Table for Singapore VPC
resource "aws_route_table_association" "singapore_private_subnet_1" {
  provider = aws.singapore
  subnet_id      = aws_subnet.singapore_private_1.id
  route_table_id = aws_route_table.singapore_private_rt.id
}

resource "aws_route_table_association" "singapore_private_subnet_2" {
  provider = aws.singapore
  subnet_id      = aws_subnet.singapore_private_2.id
  route_table_id = aws_route_table.singapore_private_rt.id
}

# Launch EC2 Instance in Mumbai Public Subnet
resource "aws_instance" "mumbai_ec2" {
  provider          = aws.mumbai
  ami               = "ami-0c55b159cbfafe1f0"  # Example AMI ID (Amazon Linux 2) for Mumbai region
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.mumbai_public_1.id
  associate_public_ip_address = true

  tags = {
    Name = "mumbai-ec2"
  }
}

# Launch EC2 Instance in Singapore Public Subnet
resource "aws_instance" "singapore_ec2" {
  provider          = aws.singapore
  ami               = "ami-0b898040803850657"  # Example AMI ID (Amazon Linux 2) for Singapore region
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.singapore_public_1.id
  associate_public_ip_address = true

  tags = {
    Name = "singapore-ec2"
  }
}

