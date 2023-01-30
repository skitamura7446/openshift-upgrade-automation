

resource "aws_vpc" "rds-vpc" {
    cidr_block = "192.168.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {
      Name = "rds-vpc"
    }
}

resource "aws_subnet" "private-subnet1" {
    vpc_id = "${aws_vpc.rds-vpc.id}"
    cidr_block = "192.168.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "private-subnet1"
    }
}

resource "aws_subnet" "private-subnet2" {
    vpc_id = "${aws_vpc.rds-vpc.id}"
    cidr_block = "192.168.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "private-subnet2"
    }
}

resource "aws_db_subnet_group" "praivate-db" {
    name        = "praivate-db"
    subnet_ids  = ["${aws_subnet.private-subnet1.id}", "${aws_subnet.private-subnet2.id}"]
    tags = {
        Name = "praivate-db"
    }
}

resource "aws_security_group" "praivate-db-sg" {
    name = "praivate-db-sg"
    vpc_id = "${aws_vpc.rds-vpc.id}"
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "public-db-sg"
    }
}

resource "aws_db_instance" "test-db" {
  identifier           = "sample-blog-db"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name                 = "sampleblog"
  username             = "sampleblog"
  password             = "sampleblog"
  vpc_security_group_ids  = ["${aws_security_group.praivate-db-sg.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.praivate-db.name}"
  skip_final_snapshot = true
}

output "db_instance_endpoint" {
  value = aws_db_instance.test-db.endpoint
}

output "rds_vpc_id" {
  value = aws_vpc.rds-vpc.id
}
