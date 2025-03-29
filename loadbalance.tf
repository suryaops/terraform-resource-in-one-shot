resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0198269a7efa5127d"]
  subnets            = ["subnet-0aa7dc87e107f8633", "subnet-03b3ca7fc2e2bde67"]
}

# Target Groups
resource "aws_lb_target_group" "home" {
  name     = "home"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-01cba72ba2e95c831"
}

resource "aws_lb_target_group" "laptop" {
  name     = "laptop"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-01cba72ba2e95c831"
}

resource "aws_lb_target_group" "mobile" {
  name     = "mobile"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-01cba72ba2e95c831"
}

# Attach ASGs to Target Groups
resource "aws_autoscaling_attachment" "asg_home" {
  autoscaling_group_name = aws_autoscaling_group.home_asg.name
  lb_target_group_arn    = aws_lb_target_group.home.arn
}

resource "aws_autoscaling_attachment" "asg_laptop" {
  autoscaling_group_name = aws_autoscaling_group.laptop_asg.name
  lb_target_group_arn    = aws_lb_target_group.laptop.arn
}

resource "aws_autoscaling_attachment" "asg_mobile" {
  autoscaling_group_name = aws_autoscaling_group.mobile_asg.name
  lb_target_group_arn    = aws_lb_target_group.mobile.arn
}

# Load Balancer Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.home.arn
  }
}

# Listener Rules for Laptop and Mobile Paths
resource "aws_lb_listener_rule" "laptop" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.laptop.arn
  }

  condition {
    path_pattern {
      values = ["/laptop/*"]
    }
  }
}

resource "aws_lb_listener_rule" "mobile" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mobile.arn
  }

  condition {
    path_pattern {
      values = ["/mobile/*"]
    }
  }
}
