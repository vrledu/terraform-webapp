output "vpc_id" {
  value = aws_vpc.web-app-vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.web-app-vpc.cidr_block
}

output "public_subnet_1" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet_2" {
  value = aws_subnet.public-subnet-2.id
}

output "public_subnet_3" {
  value = aws_subnet.public-subnet-3.id
}

output "private_subnet_1" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet_2" {
  value = aws_subnet.private-subnet-2.id
}

output "private_subnet_3" {
  value = aws_subnet.private-subnet-3.id
}
