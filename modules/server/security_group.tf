resource "aws_security_group" "allow_ssh" {
  name_prefix        = "sg_aula_ssh"
  description = "Allow ssh inbound traffic"
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_ips
  }
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "web_egress" {
  name_prefix = "sg_aula_web_egress"
  description = "Permite trafego de saida para internet"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
