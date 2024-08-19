terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfManagement"
    storage_account_name = "stoddmgmttesttf"
    container_name       = "tfstate"
    
  }
}