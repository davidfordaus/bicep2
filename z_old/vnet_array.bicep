param location string = resourceGroup().location
param vnetName string // testVnet
param subnetNumber int // example : 3 subnets
param addressPrefix string // example : 10.0.0.0/16
param subnetPrefix string

// var virtualNetworkName = 'my-vnet'
// var subnet1Name = 'Subnet-1'
// var subnet2Name = 'Subnet-2'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [for i in range(0, subnetNumber) : {
        name: '${subnetPrefix}-${i}-net'
        properties: {
          addressPrefix: '10.0.${i}.0/24'
        }
      }]
  }

  // resource subnet1 'subnets' existing = {
  //   name: subnet1Name
  // }

  // resource subnet2 'subnets' existing = {
  //   name: subnet2Name
  // }
}

// output subnet1ResourceId string = virtualNetwork::subnet1.id
// output subnet2ResourceId string = virtualNetwork::subnet2.id
