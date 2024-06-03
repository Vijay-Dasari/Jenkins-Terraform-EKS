resource "aws_security_group" "my_sg" {
  name = "eks_cluster_sg_terraform"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group_rule" "sg_ingress" {
#   security_group_id = aws_security_group.my_sg.id
#   type = "ingress"
#   description       = "allow inbound traffic from eks"
#   from_port         = 0
#   protocol          = "-1"
#   to_port           = 0
#   cidr_blocks = ["10.0.0.0/8",
#     "172.16.0.0/12",
#     "192.168.0.0/16"  ]
# }

# resource "aws_security_group_rule" "sg_egress" {
#   security_group_id = aws_security_group.my_sg.id
#   type = "ingress"
#   description       = "allow outbound traffic to internet"
#   from_port         = 0
#   protocol          = "-1"
#   to_port           = 0
#   cidr_blocks = ["0.0.0.0/0" ]
# }