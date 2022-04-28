resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allow access to this server"
  vpc_id      = data.aws_vpc.main_vpc.id

  #INBOUND CONNECTIONS
  ingress {
    description     = "Allow SSH into the EC2"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.loadbalancer_sg.id]
  }

  #OUTBOUND CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "loadbalancer_sg" {
  name        = "lb_sg"
  description = "Allow access to this LoadBalancer"
  vpc_id      = data.aws_vpc.main_vpc.id

  #INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ACCESS to the Web server from internet
  }

  #OUTBOUND CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Allow access to DB instance"
  vpc_id      = data.aws_vpc.main_vpc.id

  ingress {
    description = "Allow EC2 instance to access RDS Database"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # OUTBOUD CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}
    
  
