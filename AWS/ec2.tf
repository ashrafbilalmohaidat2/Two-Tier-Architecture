resource "aws_instance" "instance1" {
    ami = var.ami-id
    instance_type = var.instance-type
    subnet_id = aws_subnet.public-subnet1.id
    security_groups = [aws_security_group.sg.id]
    key_name = var.key-name
    user_data = filebase64("user-data.sh")

    tags = {
      Name = "instance1"
    }
}

resource "aws_instance" "instance2" {
    ami = var.ami-id
    instance_type = var.instance-type
    subnet_id = aws_subnet.public-subnet2.id
    security_groups = [aws_security_group.sg.id]
    key_name = var.key-name
    user_data = filebase64("user-data.sh")

     tags = {
      Name = "instance2"
    }
}