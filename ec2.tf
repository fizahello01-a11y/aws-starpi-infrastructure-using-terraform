data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  owners = ["amazon"]
}
resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

docker run -d \
  --name strapi \
  -p 1337:1337 \
  -e NODE_ENV=development \
  strapi/strapi
EOF



  tags = {
    Name = "${var.project_name}-ec2"
  }
}
