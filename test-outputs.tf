output "a_vnet_id" {
  value = module.spcc_virtual_network.vnet_id
}

output "b_subnets" {
  value = module.spcc_virtual_network.vnet_subnets[*]
}

output "c_Key_Vault_for_storing_Admin_Passwords" {
  value = azurerm_key_vault.keyvault.name
}
