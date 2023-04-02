##############################################
# 目的：秘密鍵と公開鍵を作成して、KeyPairを作成します
##############################################

# keypair で使用する秘密鍵と公開鍵の作成
locals {
  privatekey = "${var.keypair_config.key_file_path}/${var.keypair_config.key_name}.pem"
  publickey  = "${var.keypair_config.key_file_path}/${var.keypair_config.key_name}"
}

resource "tls_private_key" "rsa-keygen" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

# 作成したキーから秘密鍵のファイルを生成
resource "local_file" "privatekey_pem" {
  filename        = local.privatekey
  content         = tls_private_key.rsa-keygen.private_key_pem
  file_permission = "600"
}

# 作成したキーから公開鍵のファイルを生成
resource "local_file" "public_openssh" {
  filename        = local.publickey
  content         = tls_private_key.rsa-keygen.public_key_openssh
  file_permission = "600"
}

# keypairを作成
resource "aws_key_pair" "key_pair" {
  key_name   = var.keypair_config.key_pair_name
  public_key = tls_private_key.rsa-keygen.public_key_openssh
  tags       = var.keypair_config.tags
}

