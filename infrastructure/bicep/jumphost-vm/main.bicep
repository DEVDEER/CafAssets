targetScope = 'subscription'

@description('The lower case name of the project as it appears in Azure DevOps.')
param projectName string

@description('The Azure region to deploy the resource to.')
param location string

resource group 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'rg-${toLower(projectName)}-jumphost'
  location: location
}

module applyLock 'modules/Microsoft.Authorization/locks.bicep' = {
  scope: group
  name: 'applyLock'
}

module resources 'resources.bicep' = {
  scope: group
  name: 'resources'
  params: {
    location: location
    projectName: projectName
  }
}
