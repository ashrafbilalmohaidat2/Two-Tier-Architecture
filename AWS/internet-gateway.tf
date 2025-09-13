resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.ig-name
  }
}

