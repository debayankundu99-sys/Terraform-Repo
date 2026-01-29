variable "my_ip" {
  description = "Your public IP for SSH/HTTP"
  type = string
}

resource "aws_security_group" "bastion_sg" {
  name = "bastion_sg"
  vpc_id = aws_vpc.debayanvpc.id


ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [var.my_ip]
 }
egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "private_sg" {
  name = "private-sg"
  vpc_id = aws_vpc.debayanvpc.id


  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [aws_vpc.debayanvpc.cidr_block]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"
  vpc_id = aws_vpc.debayanvpc.id


  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
