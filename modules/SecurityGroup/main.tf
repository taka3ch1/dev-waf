###########################################
# セキュリティグループを作成します
###########################################


resource "aws_security_group" "security_group" {
  name        = var.security_group_config.name
  vpc_id      = var.security_group_config.vpc_id
  description = var.security_group_config.description
  # アウトバウンドの拒否設定は行わない
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 0
    protocol         = -1
    to_port          = 0
    ipv6_cidr_blocks = ["::/0"]

  }
  tags = var.security_group_config.tags
}