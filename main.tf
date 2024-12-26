locals{
  name = "${var.env}-${var.cluster_name}"
}
resource "aws_eks_cluster" "example" {
  name = local.name

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.30"

  vpc_config {
    subnet_ids = [
      "subnet-0f91105ac5e421ff1",
      "subnet-0eeff0ad570056c98"
      
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}


