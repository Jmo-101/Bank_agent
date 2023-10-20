provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

resource "aws_instance" "Bank_jenkins" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.pubsub1.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  user_data              = file("Jenkinsdeploy.sh")
  key_name = "D5.1_key"


  tags = {
    "Name" = "5.1_Jenkins"
  }
}

resource "aws_instance" "bank_python" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.pubsub1.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  user_data              = file("pythondeploy.sh")
  key_name = "D5.1_key"

  tags = {
    "Name" = "5.1_python"
  }
}

resource "aws_instance" "bank_python2" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.pubsub2.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  user_data              = file("pythondeploy.sh")
  key_name = "D5.1_key"


  tags = {
    "Name" = "5.1_agent"
  }
}



resource "aws_security_group" "web_ssh" {
  name        = "D5.1_sg"
  description = "open ssh traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 8000
    to_port     = 8000
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
    "Name" : "D5.1_sg"
    "Terraform" : "true"
  }

}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "D5.1vpc"
  }
}

resource "aws_subnet" "pubsub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub1"
  }
}

resource "aws_subnet" "pubsub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

#outputs new instance IP in the terminal 
output "instance_ip" {
  value = aws_instance.Bank_jenkins.public_ip
}

output "instance_ip2" {
  value = aws_instance.bank_python.public_ip
}

output "instance_ip3" {
  value = aws_instance.bank_python2.public_ip
}
