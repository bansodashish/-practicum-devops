# variable "region" {
#   description = "AWS region in which resources are deployed"
#   type        = string
# }
# variable "vpc_name" {
#   description = "AWS region in which resources are deployed"
#   type        = string
# }

variable "ssh_private_key_file" {
  type        = string
  description = "Name of the file containing the deployer SSH *private* key (will be used for provisioning in Nginx)"
}

variable "keypair_name" {
  type        = string
  description = "Name of the keypair (will be used to authorize access to instances)"
}