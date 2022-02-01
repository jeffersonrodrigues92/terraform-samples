provider "aws" {
    region = "us-east-1"
}

variable "vpc_name" {
    type = string
    default = "myvpc"
  
}

variable "ssh_port" {
    type = number
    default = 22 
}

variable "enabled" {
    default = true
}

variable "mylist" {
    type = list(string)
    default = [ "Value1", "Value2"]
}

variable "mymap" {
  type = map
  default = {
      key1 = "Value1",
      key2 = "Value2"
  }
}

//Parameters or Inputs
variable "vpc_name_parameter" {
    type = string
    description = "Set the name of the vpc" 
}

//Outputs
output "vpc_id" {
    value = aws_vpc.myvpc.id
}


//Tuples
variable "tuple" {
    type = tuple ([string, number, string])
    default = ["dog", 1, "cat"]
}

//Objects
variable "myobjects" {
  type = object({name= string, port=list(number)})
  default = {
      name= "Jeff",
      port= [22, 80, 443],
    }
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.vpc_name_parameter
    }
}



