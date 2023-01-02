module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier        = "currency-explorer-db"
  engine            = "postgres"
  engine_version    = 13.5
  family            = "postgres13"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20
  vpc_security_group_ids = [aws_security_group.open_security_group.id]
  maintenance_window = "sun:05:00-sun:06:00"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  publicly_accessible           = true
  performance_insights_enabled  = true
  create_random_password        = false
  multi_az                      = false
  deletion_protection           = false # for now
  storage_encrypted             = false # not supported by free trial
}

resource "aws_security_group" "open_security_group" {
  name        = "open_security_group"
  description = "Allow all traffic"

  ingress {
    protocol         = "-1"
    from_port        = "0"
    to_port          = "0"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = "0"
    to_port          = "0"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Open Security Group"
  }

}