resource "aws_eip" "nat_eip" {
  # domain is optional and since ec2-classic isn't really a thing skip it!!
  #domain = "vpc" # means eip is for use in an vpc, standard would mean its for use in ec2-classic

  tags = {
    Name = "nat_eip"
  }
}

resource "aws_nat_gateway" "nat" {
  # if you don't provide an allocaiotn_id terraform will create one an associate it with th enat gateway
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "nat"
  }

  # the nat gateway relies on an igw to provide internet access to instnaces in private subnets
  # it's best to explicitly specify the dependency
  depends_on = [aws_internet_gateway.igw]
}
