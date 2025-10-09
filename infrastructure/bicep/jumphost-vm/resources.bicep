targetScope = 'resourceGroup'

@description('The lower case name of the project as it appears in Azure DevOps.')
param projectName string

@description('The Azure region to deploy the resource to.')
param location string

@description('Optional array of data disc definitions.')
param additionalDataDiscDefinitions array = []

@description('The name of the image version. Use `Get-AzVMImage -Location LOCATION -PublisherName PUBLISHERID -Offer OFFER_ID` to retrieve a list.')
param imageVersion string = 'latest'

var options = opt.outputs.options

module opt '../modules/options.bicep' = {
  name: 'options'
  params: {
    location: location
    projectName: projectName
  }
}

module nsg '../modules/Microsoft.Network/networkSecurityGroups.bicep' = {
  name: 'nsg'
  params: {
    options: options
    additionalName: 'jumphost'
    securityRules: [
      {
        name: 'allow-3389'
        properties: {
          priority: 300
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
        }
      }
    ]
  }
}

module vnet '../modules/Microsoft.Network/virtualNetworks.bicep' = {
  name: 'vnet'
  params: {
    options: options
    addressPrefixes: [
      '10.0.0.0/16'
    ]
  }
}

module pip '../modules/Microsoft.Network/publicIPAddresses.bicep' = {
  name: 'pip'
  params: {
    options: options
    additionalName: 'jumphost'
    dnsLabel: 'jumphost'
    allocationMethod: 'Static'
    skipDiagnostics: true
  }
}

module nic '../modules/Microsoft.Network/networkInterfaces.bicep' = {
  name: 'nic'
  params: {
    options: options
    subnetId: vnet.outputs.subnets[0].id
    nsgId: nsg.outputs.id
    loadBalancerBackendAddressPools: []
    loadBalancerInboundNatRules: []
    publicIpId: pip.outputs.id
    privateIp: ''
    additionalName: 'jumphost'
    skipDiagnostics: true
  }
}

module debugVirtualMachine '../modules/Microsoft.Compute/virtualMachines.bicep' = {
  name: 'vm'
  params: {
    options: options
    additionalName: 'jumphost'
    osType: 'Windows'
    vmSize: 'Standard_B1s'
    adminUser: 'devdeer'
    adminPass: 'P@ssw0rd!'
    autoShutdownTime: '2000'
    imageOffer: 'windows-11'
    imagePublisher: 'microsoftwindowsdesktop'
    imageSku: 'win11-24h2-pro'
    imageVersion: imageVersion
    nicId: nic.outputs.id
    additionalDataDiscDefinitions: additionalDataDiscDefinitions
  }
}
