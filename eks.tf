resource "aws_eks_cluster" "cloudpunch" {
  name     = "cloudpunch-cluster"
  role_arn = aws_iam_role.cloudpunch_cluster_role.arn

  vpc_config {
    subnet_ids         = aws_subnet.cloudpunch_subnet[*].id
    security_group_ids = [aws_security_group.cloudpunch_cluster_sg.id]
  }
}

resource "aws_eks_node_group" "cloudpunch" {
  cluster_name    = aws_eks_cluster.cloudpunch.name
  node_group_name = "cloudpunch-node-group"
  node_role_arn   = aws_iam_role.cloudpunch_node_group_role.arn
  subnet_ids      = aws_subnet.cloudpunch_subnet[*].id

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key = var.ssh_key_name
    source_security_group_ids = [aws_security_group.cloudpunch_node_sg.id]
  }
}

