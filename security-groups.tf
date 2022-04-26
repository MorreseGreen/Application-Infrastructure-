# Create security group for the Database
resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Allow access to DB instance"
  vpc_id      = aws_vpc.main.id

  # INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/24"] # ALL INSTANCES IN PUBLIC SUBNET IS ALLOWED TO CONNECT
  }

  ingress {
    description = "Allow EC2 instance to access RDS Database "
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

