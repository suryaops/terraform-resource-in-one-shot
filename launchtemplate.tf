resource "aws_launch_template" "home" {
  name_prefix   = "home-template"
  image_id      = "ami-084568db4383264d4"
  instance_type = "t2.micro"

  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo mkdir -p /var/www/html/home
echo "Home Instance" | sudo tee /var/www/html/home/index.html
EOF
  )
}

resource "aws_launch_template" "laptop" {
  name_prefix   = "laptop-template"
  image_id      = "ami-084568db4383264d4"
  instance_type = "t2.micro"

  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo mkdir -p /var/www/html/laptop
echo "Laptop Instance" | sudo tee /var/www/html/laptop/index.html
EOF
  )
}

resource "aws_launch_template" "mobile" {
  name_prefix   = "mobile-template"
  image_id      = "ami-084568db4383264d4"
  instance_type = "t3.micro"

  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo mkdir -p /var/www/html/mobile
echo "Mobile Instance" | sudo tee /var/www/html/mobile/index.html
EOF
  )
}
