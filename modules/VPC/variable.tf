variable "vpc_config" {
  type = object({
    cidr_blocks = string
    tags        = map(string)
  })
}

variable "private_subnet_config" {
  type = object({
    cidr_blocks       = string
    availability_zone = string
    tags              = map(string)
  })
}

variable "public_subnet_config" {
  type = object({
    cidr_blocks       = string
    availability_zone = string
    tags              = map(string)
  })
}

variable "igw_config" {
  type = object({
    tags = map(string)
  })
}

variable "private_route_table_config" {
  type = object({
    tags = map(string)
  })
}

variable "public_route_table_config" {
  type = object({
    tags = map(string)
  })
}
