resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.default.id

  tags = merge(var.global_tags, {
    Name = "private-rt"
  })
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private-1b.id
  route_table_id = aws_route_table.private.id
}
