variable "security_group_config" {
  type = object({
    name        = string
    tags        = map(string)
    vpc_id      = string
    description = string
    ingress = object({
      from_port         = string
      to_port           = string
      protocol          = string
      security_group_id = optional(list(string))
      cidr_blocks       = optional(list(string))
    })
  })
}