resource "aws_lb_target_group" "target-group" {
    name     = "target-group"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.my-vpc.id
}

resource "aws_lb_target_group_attachment" "tg-attachment-1" {
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id        = aws_instance.instance1.id
    port             = 80
  
}

resource "aws_lb_target_group_attachment" "tg-attachment-2" {
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id        = aws_instance.instance2.id
    port             = 80
}