variable "resourceGroupName" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-management"
}

variable "projectName" {
  description = "The name of the project or the subscription"
  type        = string
}

variable "companyShort" {
  description = "The short name of the company"
  type        = string
}

variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = "westeurope"
}

variable "keyVaultShort" {
  description = "The short name of the key vault resource"
  type        = string
  default     = "akv"
}

locals {
  keyVaultName = "${var.keyVaultShort}-${var.companyShort}-${var.projectName}-mgmt"
}
