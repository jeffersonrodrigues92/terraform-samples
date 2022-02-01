provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "eip_instance" {
  instance = aws_instance.instance.id
}

output "eip" {
    value = aws_eip.eip_instance.public_ip
}

resource "aws_security_group" "instance_rules" {
  name        = "instance_rules"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-09f7093436b7eb2ca"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance_rules"
  }
}

resource "aws_instance" "instance" {
  ami = "ami-0a8b4cd432b1c3063"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance_rules.name]

  tags = {
    Name = "Hello EC2 Instances"
  }
}