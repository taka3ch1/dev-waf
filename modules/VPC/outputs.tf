output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public-subnet_id" {
  value = aws_subnet.public_subnet.id
}
output "private-subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "internet-gataway_id" {
  value = aws_internet_gateway.vpc_igw.id
}
