resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }
    tags = {
        Name = var.public-rt-name
    }
}

resource "aws_route_table_association" "public-rt-1" {
    subnet_id = aws_subnet.public-subnet1.id
    route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-rt-2" {
    subnet_id = aws_subnet.public-subnet2.id
    route_table_id = aws_route_table.public-rt.id
}