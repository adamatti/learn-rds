data "aws_subnet" "public-1a" {
  // FIXME
  id = "subnet-049bc57fe5ad51e4d"
}

resource "aws_subnet" "private-1a" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "sa-east-1a"

  tags = merge(var.global_tags, {
    Name = "private-subnet-1a"
  })
}

resource "aws_subnet" "private-1b" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "172.31.112.0/20"
  availability_zone = "sa-east-1b"

  tags = merge(var.global_tags, {
    Name = "private-subnet-1b"
  })
}

resource "aws_db_subnet_group" "private-group" {
  subnet_ids = [
    aws_subnet.private-1a.id,
    aws_subnet.private-1b.id
  ]

  tags = merge(var.global_tags, {
    Name = "private-group"
  })
}
