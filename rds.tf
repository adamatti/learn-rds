resource "aws_kms_key" "db-password" {

}

resource "aws_security_group" "rds" {
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.global_tags, {
    Name = "private-subnet-rds-sg"
  })
}

resource "aws_security_group_rule" "rds_egress_to_ec2" {
  security_group_id = aws_security_group.rds.id

  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.public-sg.id
}

resource "aws_db_instance" "default" {
  identifier        = "testdb"
  allocated_storage = 20
  db_name           = "mydb"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t2.micro"
  username          = "foo"
  // master_user_secret_kms_key_id = aws_kms_key.db-password.key_id
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.private-group.id
  availability_zone      = "sa-east-1a"
  vpc_security_group_ids = [aws_security_group.rds.id]
  port                   = 3306

  # Test only
  skip_final_snapshot = true

  // FIXME DO NOT USE PLAIN PASSWORD
  password = var.database_password

  tags = merge(var.global_tags, {})
}

output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}
