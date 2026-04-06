terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "cidr" {
default = "10.0.0.0/16"  
}

resource "aws_key_pair" "example" {
  key_name   = "terrafrom-key"
  public_key = file("C:/Users/meabi/.ssh/id_ed25519.pub")
}

resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true 
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.RT.id
}


resource "aws_security_group" "sg1" {
    name = "sg"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "HTTP from VPC"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
   }
   
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "Web-sg"
  }
}


resource "aws_instance" "server" {
    ami = "ami-0ec10929233384c7f"
    instance_type = "t3.micro"
    key_name = aws_key_pair.example.key_name
    vpc_security_group_ids = [aws_security_group.sg1.id]
    subnet_id = aws_subnet.sub1.id

    connection {
    type        = "ssh"
    user        = "ubuntu"  
    private_key = file("C:/Users/meabi/.ssh/id_ed25519")  
    host        = self.public_ip
  }
  
  provisioner "file" {
    source      = "app.py"  
    destination = "/home/ubuntu/app.py"  
  }

  provisioner "remote-exec" {
  inline = [
    "echo 'Hello from the remote instance'",
    "sudo apt update -y",
    "sudo apt-get install -y python3-pip python3-flask",
    "cd /home/ubuntu",
    "nohup python3 app.py &"
  ]
}
}