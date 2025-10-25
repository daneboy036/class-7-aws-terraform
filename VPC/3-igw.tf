resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name    = "app1_IG"
    Service = "application1"
  }
}

# remembrer that igw is free to create and you pay for all outbound internet traffic
