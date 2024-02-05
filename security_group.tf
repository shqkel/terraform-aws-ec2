resource "aws_security_group" "hello_ec2_sg" {
  name_prefix = "hello-ec2-sg"
}

resource "aws_security_group_rule" "hello_ec2_sg_ingress_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  security_group_id = aws_security_group.hello_ec2_sg.id
}

resource "aws_security_group_rule" "hello_ec2_sg_ingress_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.hello_ec2_sg.id
}

resource "aws_security_group_rule" "hello_ec2_sg_ingress_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.hello_ec2_sg.id
}
resource "aws_security_group_rule" "hello_ec2_sg_ingress_app" {
  type        = "ingress"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.hello_ec2_sg.id
}
resource "aws_security_group_rule" "hello_ec2_sg_egress_all" {
  type             = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.hello_ec2_sg.id
}
