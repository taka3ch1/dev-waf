variable "ec2_config" {
  type = object({
    ami                    = string
    instance_type          = string
    subnet_id              = string
    vpc_security_group_ids = list(string)
    tags                   = map(string)
    key_name = string
  })
}