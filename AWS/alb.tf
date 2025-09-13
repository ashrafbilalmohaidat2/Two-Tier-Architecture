resource "aws_lb" "load-balancer" {
    name = var.lb-name
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lb-sg.id]
    subnets = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id]
    tags = {
        Environment = "production"
    }
}

resource "aws_lb_listener" "web-tier" {
    load_balancer_arn = aws_lb.load-balancer.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.target-group.arn
    }
}