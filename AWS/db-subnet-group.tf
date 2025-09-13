resource "aws_db_subnet_group" "subnet-grp" {
  name       = var.db-subnet
  subnet_ids = [aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id]
}