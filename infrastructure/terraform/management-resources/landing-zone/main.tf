terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.52.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
data "azurerm_client_config" "current" {}
resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
  tags = {
    purpose = "Demo"
  }
}

# resource "azurerm_management_lock" "no-delete-lock" {
#   name       = "nodelete"
#   scope      = azurerm_resource_group.rg.id
#   lock_level = "CanNotDelete"
#   notes      = "Protects the resource group from accidental deletion."
# }

resource "azurerm_storage_account" "storage" {
  name                     = local.storageAccountName
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
}

resource "azurerm_network_watcher" "nw" {
  name                = local.networkWatcherName
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_key_vault" "management" {
  name                            = local.keyVaultName
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  enabled_for_disk_encryption     = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 90
  purge_protection_enabled        = true
  enable_rbac_authorization       = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  sku_name                        = "standard"
}
