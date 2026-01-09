// Security Group for RDS allowing inbound MySQL traffic from EC2 instances
resource "aws_security_group" "rds_sg" {
  name   = "${var.project_name}-rds-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}
// Allow EC2 security group to access RDS on port 3306
resource "aws_security_group_rule" "allow_ec2_to_rds" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"

  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = var.ec2_sg_id
}

//sunbnet group for RDS
resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

//RDS Instance
resource "aws_db_instance" "this" {
  identifier              = "${var.project_name}-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"

  allocated_storage       = 20
  storage_type            = "gp2"

  db_name                 = "appdb"
  username                = "admin"
  password                = "StrongPassword123!"   # improve later

  multi_az                = true
  publicly_accessible     = false

  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "${var.project_name}-rds"
  }
}

