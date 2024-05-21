targetScope = 'subscription'

@description('The Azure region to deploy the resource to.')
param location string

@description('The name of the project, is used for naming the created resources.')
param projectName string

@description('The name of the resource group which gets deployed here.')
param resourceGroupName string

resource group 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
  tags: {
    project: projectName
  }
}

module applyLock '../../modules/Microsoft.Authorization/locks.bicep' = {
  scope: group
  name: 'applyLock'
}

module managementResources 'resources.bicep' = {
  name: 'managementResources'
  scope: group
  params: {
    location: location
    projectName: projectName
  }
}
