// @minLength(3)
// @maxLength(24)
// @description('storage name')
// param storageName string='dfbicepstore'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'test-df-vnet'
  tags: {
    Customer:'bicep'
  }
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

// resource exampleStorage 'Microsoft.Storage/storageAccounts@2022-05-01' = {
//   name: storageName
//   location: resourceGroup().location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
// }

