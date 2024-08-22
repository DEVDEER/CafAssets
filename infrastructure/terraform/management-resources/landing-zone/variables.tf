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

variable "storageAccountShort" {
  description = "The short name of the storage account resource"
  type        = string
  default     = "sto"
}

variable "networkWatcherShort" {
  description = "The short name of the network watcher resource"
  type        = string
  default     = "nw"
}

variable "keyVaultShort" {
  description = "The short name of the key vault resource"
  type        = string
  default     = "akv"
}

locals {
  storageAccountName = "${var.storageAccountShort}${var.companyShort}mgmt${var.projectName}"
  keyVaultName       = "${var.keyVaultShort}-${var.companyShort}-mgmt-${var.projectName}"
  networkWatcherName = "${var.networkWatcherShort}-${var.companyShort}-mgmt-${var.projectName}"
}
