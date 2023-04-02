variable "keypair_config" {
  type = object({
    key_name      = string
    key_file_path = string
    key_pair_name = string
    tags          = map(string)
  })
}