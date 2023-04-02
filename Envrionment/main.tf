##############################################
# 目的:
# 作成日: 2023/3/19
# Version: 0.1
# 作成者: takas3chi
##############################################

locals {
  project_name = "2023_Report"
}

# VPCの作成
module "vpc" {
  source = "../modules/VPC"
  vpc_config = {
    tags = {
      Name        = "waf-vpc"
      projectname = local.project_name
    }
    cidr_blocks = "10.0.0.0/16"

  }
  private_subnet_config = {
    cidr_blocks       = "10.0.1.0/24"
    availability_zone = "ap-northeast-1a"
    tags = {
      Name        = "waf-private-subnet-01"
      projectname = local.project_name
    }
  }
  public_subnet_config = {
    cidr_blocks       = "10.0.252.0/24"
    availability_zone = "ap-northeast-1c"
    tags = {
      Name        = "waf-public-subnet-01"
      projectname = local.project_name
    }
  }
  igw_config = {
    tags = {
      Name        = "waf-igw"
      projectname = local.project_name
    }
  }
  public_route_table_config = {
    tags = {
      Name        = "waf-public-route-table"
      projectname = local.project_name
    }
  }
  private_route_table_config = {
    tags = {
      Name        = "waf-private-route-table"
      projectname = local.project_name
    }
  }

}

# キーペアの作成
module "key_pair" {
  source = "../modules/KeyPair"
  keypair_config = {
    key_name      = "waf-host01-keypair"
    key_file_path = "../.ssh"
    key_pair_name = "waf-host01-key"
    tags = {
      projectname = local.project_name
    }
  }
}

# セキュリティグループの作成
module "ALB-security_group-https" {
  source = "../modules/SecurityGroup"
  security_group_config = {
    vpc_id      = module.vpc.vpc_id
    description = "ALB"
    ingress = {
      cidr_blocks = ["0.0.0.0"]
      from_port   = "443"
      protocol    = "https"
      # security_group_id = [ "value" ]
      to_port = "443"
    }
    name = "WAF-ALB-SG"
    tags = {
      projectname = local.project_name
    }
  }
}
data "aws_ami" "recent_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.0.????????.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

module "EC2-Host01" {
  source = "../modules/EC2"
  ec2_config = {
    ami           = data.aws_ami.recent_ami.image_id
    instance_type = "t2.micro"
    subnet_id     = module.vpc.private-subnet_id
    tags = {
      Name = "EC2-Host01"
      projectname = local.project_name
    }
    vpc_security_group_ids = [module.ALB-security_group-https.security_group_id]
    key_name = module.key_pair.key_pair_id
  }

}

module "EC2-Host02" {
  source = "../modules/EC2"
  ec2_config = {
    ami           = data.aws_ami.recent_ami.image_id
    instance_type = "t2.micro"
    subnet_id     = module.vpc.private-subnet_id
    tags = {
      Name = "EC2-Host02"
      projectname = local.project_name
    }
    vpc_security_group_ids = [module.ALB-security_group-https.security_group_id]
    key_name = module.key_pair.key_pair_id
  }
}



