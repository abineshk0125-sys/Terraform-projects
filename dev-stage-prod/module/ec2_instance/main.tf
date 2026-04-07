provider "aws" {
    region = "us-east-1"  
}

variable "ami" {
    description = "type of ami"  
}

variable "instance_type" {
    description = "type of instance example: t2.micro"
}

resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.instance_type
}
