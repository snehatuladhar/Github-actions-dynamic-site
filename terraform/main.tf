resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance
  iam_instance_profile   = var.iam_instance_profile
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.network_security_group.id]
  subnet_id              = var.subnet_id

  tags = {
    Name = "ProjectServerInstance"
  }
}


resource "aws_security_group" "network_security_group" {
  name        = var.network_security_group_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "SSM"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nsg-inbound"
  }
}