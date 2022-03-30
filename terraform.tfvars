#Common variables
resource_group_name = "infra-rg-aue-test"
location            = "Australia East"

tags = {
  environment = "TEST"
  product     = "Core Infrastructure"
}

# Optional Resource Group(s) for VMs
vm_rg_name_01 = "ad-rg-aue-test"
vm_rg_name_02 = "vpn-rg-aue-test"


# Virtual Network
vnet_name     = "spcc-test-vnet"
address_space = ["10.120.0.0/16", "192.168.0.0/16"]

subnet_names    = ["dcnetwork", "vpnnetwork", "benetwork", "testsubnet"]
subnet_prefixes = ["10.120.12.0/24", "10.120.15.0/24", "10.120.121.0/24", "192.168.1.0/24"]


# KeyVault that contains the passwords of Local Administrator
key_vault_name = "infra-kv-aue-test"
key_vault_sku  = "standard"

