data "aws_key_pair" "sample" {
  key_name = "sample"
}

data "aws_ami" "aws-linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_security_group" "public-sg" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
      // data.aws_vpc.default.cidr_block
    ]
    ipv6_cidr_blocks = [
      "::/0"
      // data.aws_vpc.default.ipv6_cidr_block
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.global_tags, {
    Name = "public-sg"
  })
}

resource "aws_instance" "jump-box" {
  ami                         = data.aws_ami.aws-linux.id
  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.sample.key_name
  subnet_id                   = data.aws_subnet.public-1a.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.public-sg.id]

  tags = merge(var.global_tags, {
    Name = "jump-box"
  })
}

output "ecs-public-dns" {
  value = aws_instance.jump-box.public_dns
}

output "ecs-public-ip" {
  value = aws_instance.jump-box.public_ip
}
