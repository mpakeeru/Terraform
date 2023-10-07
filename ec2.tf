



# Create AWS key_pair

resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = tls_private_key.rsa-key.public_key_openssh
}

# Create private key

resource "tls_private_key" "rsa-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the key.pem file in local directory

resource "local_file" "test-key-private" {
  content  = tls_private_key.rsa-key.private_key_pem
  filename = "test-key.pem"
}

resource "aws_instance" "test-web-server" {
  ami           = var.ubuntu-ami
  instance_type = "t2.micro"
  key_name = "test-key"
  subnet_id = aws_subnet.public_subnet.1.id
  vpc_security_group_ids = [ aws_security_group.test-sg.id ]
  user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-11-jdk -y
sudo apt install tomcat9 tomcat9-admin tomcat9-docs tomcat9-common git -y
  EOF

  tags = {
    Name = "test-web-server"
    Environment = "{$var.environment}"
  }
}

resource "aws_security_group" "test-sg" {
  name = "test-sg"
  vpc_id = aws_vpc.vpc.id

  #Incoming traffic
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Outgoing traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}