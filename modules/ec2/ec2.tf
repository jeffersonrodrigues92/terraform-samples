variable "ec2_name" {
    type = string
}


resource "aws_instance" "instance" {
  ami = "ami-0a8b4cd432b1c3063"
  instance_type = "t2.micro"

  tags = {
    Name =  var.ec2_name
  }
}

output "instance_id" {
  value = aws_instance.instance.id
}