targetScope = 'resourceGroup'

@description('The Azure region to deploy the resource to.')
param location string = resourceGroup().location

@description('The name of the project, is used for naming the created resources.')
param projectName string

var options = opt.outputs.options

module opt '../../modules/options.bicep' = {
  name: 'options'
  params: {
    location: location
    projectName: projectName
    stageName: ''
    additionalName: 'mgmt'
  }
}

module keyVault '../../modules/Microsoft.KeyVault/vaults.bicep' = {
  name: 'subscriptionKeyVault'
  params: {
    options: options
    keyVaultNetworkRuleSetDefaultAction: 'Allow'
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    enableRbacAuthorization: true
  }
}

module storageAccount '../../modules/Microsoft.Storage/storageAccounts.bicep' = {
  name: 'storageAccount'
  params: {
    options: options
    allowBlobPublicAccess: false
  }
}

module networkWatcher '../../modules/Microsoft.Network/networkWatchers.bicep' = {
  name: 'networkWatcher'
  params: {
    options: options
  }
}
