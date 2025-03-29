resource "aws_autoscaling_group" "home_asg" {
  name                = "home-asg"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = ["subnet-0aa7dc87e107f8633", "subnet-03b3ca7fc2e2bde67"]

  launch_template {
    id      = aws_launch_template.home.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "laptop_asg" {
  name                = "laptop-asg"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = ["subnet-0aa7dc87e107f8633", "subnet-03b3ca7fc2e2bde67"]

  launch_template {
    id      = aws_launch_template.laptop.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "mobile_asg" {
  name                = "mobile-asg"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = ["subnet-0aa7dc87e107f8633", "subnet-03b3ca7fc2e2bde67"]

  launch_template {
    id      = aws_launch_template.mobile.id
    version = "$Latest"
  }
}
