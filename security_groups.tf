resource "aws_security_group" "cloudpunch_cluster_sg" {
  vpc_id = aws_vpc.cloudpunch_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloudpunch-cluster-sg"
  }
}

resource "aws_security_group" "cloudpunch_node_sg" {
  vpc_id = aws_vpc.cloudpunch_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloudpunch-node-sg"
  }
}

