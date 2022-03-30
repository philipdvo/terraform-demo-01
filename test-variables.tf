variable "location" {}

variable "resource_group_name" {}

variable "tags" {}

variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = "corporate-vnet"
}


variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default     = []
}


variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["subnet1"]
}

variable "key_vault_name" {}
variable "key_vault_sku" {}
variable "vm_rg_name_01" {}
variable "vm_rg_name_02" {}
