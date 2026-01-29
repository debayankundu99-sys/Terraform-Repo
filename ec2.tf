resource "aws_instance" "Bastion host" {
  ami = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_az_a.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  key_name = "aws-project"


  tags = { Name = "Bastion host" }
}

resource "aws_instance" "jenkins" {
  ami = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private_az_a.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name = "aws-project"


  tags = { Name = "Jenkins" }
}

resource "aws_instance" "app" {
  ami = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private_az_b.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name = "aws-project"


  tags = { Name = "App" }
}
