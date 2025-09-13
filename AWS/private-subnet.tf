resource "aws_subnet" "private-subnet1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private-subnet1-cidr
  availability_zone       = var.first-az
  map_public_ip_on_launch = true

   tags = {
    Name = "Private-subnet1"
  }
}

resource "aws_subnet" "private-subnet2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private-subnet2-cidr
  availability_zone       = var.second-az
  map_public_ip_on_launch = true 

  tags = {
    Name = "Private-subnet2"
  }
}