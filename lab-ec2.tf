#have to update this In this Terraform script:

#Replace "us-east-1" with your desired AWS region in the provider "aws" block.
#Set the ami attribute in the aws_instance resource block to the AMI ID you want to use.
#Change the instance_type to the desired EC2 instance type.
#Replace "your-key-pair" with the name of your EC2 key pair in the key_name attribute

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_security_group" "allow_all" {
  name_prefix = "allow-all-"
  
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "lab1-ec2-instance" {
  
  ami           = "ami-051f7e7f6c2f40dc1"  # Specify your desired AMI ID
  instance_type = "t2.micro"  # Change to your desired instance type
  key_name      = aws_key_pair.lab-part-2.key_name

  metadata_options {
    http_tokens = "optional"
    http_put_response_hop_limit = 2
    http_endpoint = "enabled"
  }



  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y git
              git clone https://github.com/Zero0x00/seasides-cloud-ec2-lab.git
              cd seasides-cloud-ec2-lab/
              python3 -m venv lab-venv 
              source lab-venv/bin/activate
              pip3 install -r requirment.txt
              nohup python3 -m flask run --host=0.0.0.0 --port=8001 &
              echo $?
              EOF

  security_groups = [aws_security_group.allow_all.name]
}

resource "aws_key_pair" "lab-part-2" {
  key_name      = "lab-part-2"  # Change to your key pair name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeY2iUXf4lv6faaSIhz05CPIlMCAm1EIM01s8CFJIIQg0fUCjMjkXT6/LcHo8d23AV/y2nFULdjdlBW30lV2m3nw3zM8Y5if5rFYXKUg+7sOD3avEeU9IszOzn95WkEgkcYkbYa9nml3hBRZFCs3OFH7mC4XW54neD6cVAW2haczAO9yz+yLfsAMzwxQngl4lv/70Dpluk/22+U+77m3lAd9dZfZ+B1wUGlUSgfEncS/gvAZMooUSt5vm53wN6umvf3NAMhbhtVvWWzIe2/Hs6xMIxzUdoc4sAJO8RHcLTlu3iebu97yDm4ryc2H8tjcPZQVfUrRKAgXj20Q4rB4WUpTk3Q1qalvXOMFPU1lERo51Ak5Cz+Z6712De+zriJpkefPquf0EMkPd3IcB1Gnk00zuAxh57IUe2IvPwUkzIgr+JqA4NKdidGlICL9y/AypKSYSYnJctzSJClbros73lWZjDQAk+SyCexYBe6GXlvxcAaojKInBg99+Bprq2tT4yv846TUZIegg1MKJiSomlK8cIWAD4scpf8tBQm0S0vjIeZZ3hVl8Cvxw991xsQ7GX1QRyqPI8eD7uPqkPdjQLQDyI6APbjTLNY4wM09r35e01O5mDF+SLGjcjEdwyJqgIHkfGhYiDzR61IOr5mVRxTpggbf3Xm4y0e57JVERgEw== Lab_part2"
}

output "instance_public_ip" {
  value = aws_instance.lab1-ec2-instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.lab1-ec2-instance.private_ip
}
