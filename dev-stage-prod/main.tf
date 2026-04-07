provider "aws" {
    region = "us-east-1"  
}

variable "ami" {
    description = "value"  
}

variable "instance_type" {
    description = "value"
    type = map(string)

    default = {
      "dev" = "t3.small"
      "stage" = "t3.micro"
      "prod" = "t3.xlarge"
   }
}

module "ec2_instance" {
    source = "./module/ec2_instance"
    ami  = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "t3.micro")
}
