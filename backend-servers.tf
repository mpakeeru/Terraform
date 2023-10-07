locals {
  web_servers = {
    my-app-00 = {
      machine_type = "t2.micro"
      subnet_id    = aws_subnet.public_subnet.1.id
    }
  }
  my-backend-servers = {
    my-mq-01 = {
      machine_type = "t2.micro"
      subnet_id    = aws_subnet.private_subnet.1.id
    
    }
    my-db-01 = {
      machine_type = "t2.micro"
      subnet_id    = aws_subnet.private_subnet.1.id
    
    }
    my-mc-01 = {
      machine_type = "t2.micro"
      subnet_id    = aws_subnet.private_subnet.1.id
    
    }
  }
}
