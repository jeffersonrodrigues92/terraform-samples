provider "aws" {
    region = "us-east-1"
}

variable "ingressrules" {
    type = list(number)
    default = [80,443]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,25,3306,53,8080]
}

resource "aws_security_group" "dynamic_rules" {
  name        = "dynamic_rules"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-09f7093436b7eb2ca"

    dynamic "ingress" {
        for_each = var.ingressrules
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "TCP"
        }
    }

    dynamic "egress" {
        for_each = var.egressrules
        content {
            from_port   = egress.value
            to_port     = egress.value
            protocol    = "TCP"
        }
    } 

  tags = {
    Name = "dynamic_rules"
  }
}
