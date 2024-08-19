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

resource "azurerm_resource_group" "rg" {
  name     = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  tags = {
    purpose = "Demo"
  }
}

resource "azurerm_key_vault" "management" {
  name                        = local.keyVaultName
  resource_group_name         = var.resourceGroupName
  location                    = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}
