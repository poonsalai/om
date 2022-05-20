data "aws_vpc" "selected" {
  default = true
}

data "aws_subnet_ids" "ex1_subnet_ids" {
  vpc_id = data.aws_vpc.selected.id
}

# creating a target group for LB
resource "aws_lb_target_group" "ex1" {
  name     = "ex1-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
}


# checking ami
data "aws_ami" "ex1" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]

  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
 owners = ["099720109477"] # Canonical
}

# AWS launch template with above AMI

resource "aws_launch_template" "ex1" {
  name_prefix   = "ex1"
  image_id      = data.aws_ami.ex1.id
  instance_type = "t2.micro"
  #user_data = filebase64("${path.module}/example.sh") --> This can be used to make a connection to DB and run an operation
  # This is why we have kept a dependency of DB on auto_scaling_group
}


# creating auto scaling group

resource "aws_autoscaling_group" "ex1" {
  availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1

  launch_template {
    id      = aws_launch_template.ex1.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.ex1.arn]
  # below dependency is so that we can run anything on DB and it is already UP
  depends_on = [aws_db_instance.ex1] 
}

# create sec group with igress port 80 open and it gets traffic from within vpc, from ALB - to be used by EC2
resource "aws_security_group" "ex1" {
  name        = "ex1-ec2"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 65322
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# create sec group with igress port 3306 open and it gets traffic from ec2 security group only, from ALB - to be used by DB
resource "aws_security_group" "ex2" {
  name        = "ex2-db"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.ex1.id]
  }

  tags = {
    Name = "allow_tls"
  }
}


# Creating an LB
resource "aws_lb" "ex1" {
  name               = "lb-ex1"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets   =   data.aws_subnet_ids.ex1_subnet_ids.ids
  enable_deletion_protection = false
}

# creating LB listner which listenes to request and send it to target group
resource "aws_lb_listener" "ex1" {
  load_balancer_arn = aws_lb.ex1.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ex1.arn
  }
}


# create a db instance

resource "aws_db_instance" "ex1" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

