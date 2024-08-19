variable "resourceGroupName" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-management"
}

variable "projectName" {
  description = "The name of the project or the subscription"
  type        = string
}

variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = "westeurope"
}

locals {
  storageAccountName = "sto${var.projectName}statemanagement"
  containerName      = "tfstate"
  keyVaultName       = "akv-${var.projectName}-management"
}
