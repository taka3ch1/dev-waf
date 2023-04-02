##############################################
# 目的: VPCとサブネットの作成
# 作成日: 2023/3/19
# Version: 0.1
# 作成者: taka3chi
##############################################

# VPCの作成
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_config.cidr_blocks
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.vpc_config.tags

}

# パブリックサブネット
resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_subnet_config.cidr_blocks
  availability_zone       = var.public_subnet_config.availability_zone
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id

  tags = var.public_subnet_config.tags
}

# プライベートサブネット
resource "aws_subnet" "private_subnet" {
  cidr_block              = var.private_subnet_config.cidr_blocks
  availability_zone       = var.private_subnet_config.availability_zone
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  tags                    = var.private_subnet_config.tags
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.igw_config.tags
}

# ルートテーブル(パブリック)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.public_route_table_config.tags
}

# プライベートサブネットにルートテーブルを追加
resource "aws_route" "private" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.vpc_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# ルートテーブル(プライベート)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.private_route_table_config.tags
}

# VPCとルートテーブルの紐付け、public
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

# VPCとルートテーブルの紐付け、private
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}
# NATゲートウェイ
/*
resource "aws_eip" "natgateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "natgateway"{
  allocation_id = aws_eip.natgateway_eip.id
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    "Name" = "waf-natgw"
    
  }
}
# NatGW用
resource "aws_route" "private_natgw" {
  route_table_id         = aws_route_table.private.id
  gateway_id             = aws_nat_gateway.natgateway.id
  destination_cidr_block = "0.0.0.0/0"
}
*/