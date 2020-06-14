resource "aws_security_group" "allow_http" {
  name        = "sg_aula_web"
  description = "Permite trafego de entrada HTTP"
  ingress {
    description = "Entrada HTTP de qualquer lugar"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}

resource "aws_security_group" "allow_mysql" {
  name        = "sg_aula_mysql"
  description = "Permite que as maquinas do sg_aula_web conectem no MySQL"
  ingress {
    description = "Acesso MySQL a partir do sg_aula_web"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_http.id]
  }
  tags = {
    Name = "allow_mysql"
  }
}