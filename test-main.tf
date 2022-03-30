# Create the main resource group for Virtual Network
resource "azurerm_resource_group" "spcc_main_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

# Create the 1st resource group for VMs (optional)
resource "azurerm_resource_group" "vm_rg_01" {
  name     = var.vm_rg_name_01
  location = var.location

  tags = var.tags
}

# Create the 2nd resource group for VMs (optional)
resource "azurerm_resource_group" "vm_rg_02" {
  name     = var.vm_rg_name_02
  location = var.location

  tags = var.tags
}

module "spcc_virtual_network" {
  #source              = "./Modules/terraform-azure-virtual-network"
  #source              = "git::https://github.com/philipdvo/terraform-azure-virtual-network.git
  source  = "philipdvo/virtual-network/azure"
  version = "1.0.0"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_names        = var.subnet_names
  subnet_prefixes     = var.subnet_prefixes


  subnet_enforce_private_link_endpoint_network_policies = {
    "testsubnet" : true
  }

  subnet_service_endpoints = {
    "testsubnet" : ["Microsoft.Sql", "Microsoft.Storage"]
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.spcc_main_rg
  ]
}

# Get Tenant ID
data "azurerm_client_config" "current_principal" {
}


#Create Key Vault that will store the passwords of Local Administrator
resource "azurerm_key_vault" "keyvault" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current_principal.tenant_id
  sku_name                   = var.key_vault_sku
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.spcc_main_rg
  ]
}

# Add Current Principal to KV Access Policy
resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = azurerm_key_vault.keyvault.id

  tenant_id = data.azurerm_client_config.current_principal.tenant_id
  object_id = data.azurerm_client_config.current_principal.object_id

  key_permissions    = ["get", "list"]
  secret_permissions = ["get", "list", "set", "delete", "purge", "recover", "backup", "restore"]
}

