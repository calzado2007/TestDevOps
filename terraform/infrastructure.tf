# Crear un grupo de seguridad
resource "aws_security_group" "project_devops" {
  name        = "project_devops-sg"
  description = "Grupo de seguridad de project_devops"

  # Regla de entrada para el tráfico HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida para el tráfico HTTP
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Crear una subred
resource "aws_subnet" "example" {
  cidr_block = "172.16.0/24"
  vpc_id     = aws_vpc.project_devops.id
  availability_zone = "us-east-1a"
}

# Crear una VPC
resource "aws_vpc" "project_devops" {
  cidr_block = "192.168.0.0/16"
}
