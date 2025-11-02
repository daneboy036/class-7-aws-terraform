# EC2 -> Dashboard -> Look under Service Health to see all available zones and their zone ids
resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.32.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1a"
    Service = "application1"
  }
}

resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.32.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1b"
    Service = "application1"
  }
}

resource "aws_subnet" "public-us-east-1c" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.32.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1c"
    Service = "application1"
  }
}



# private subnets
resource "aws_subnet" "private-us-east-1a" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.32.11.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-us-east-1a"
    Service = "application1"
  }
}

resource "aws_subnet" "private-us-east-1b" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.32.12.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-us-east-1b"
    Service = "application1"
  }
}

resource "aws_subnet" "private-us-east-1c" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.32.13.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-us-east-1c"
    Service = "application1"
  }
}
