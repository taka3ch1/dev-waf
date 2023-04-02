##############################################
# 目的:Ec2の作成用モジュール
# 作成日: 2023/3/19
# Version: 0.1
##############################################

resource "aws_instance" "create_ec2" {
  ami                    = var.ec2_config.ami
  instance_type          = var.ec2_config.instance_type
  subnet_id              = var.ec2_config.subnet_id
  vpc_security_group_ids = var.ec2_config.vpc_security_group_ids
  tags                   = var.ec2_config.tags

  user_data = <<EOF
    #!/bin.bash
    yum install httpd
    systemctl start httpd.service
  EOF
  key_name = var.ec2_config.key_name
}