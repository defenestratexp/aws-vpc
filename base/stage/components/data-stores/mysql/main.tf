provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "testdb" {
  identifier_prefix   = "testdb"
  engine              = "mysql"
  allocated_storate   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = "testdb"

  # Credentials
  username = var.db_username
  password = var.db_password
}