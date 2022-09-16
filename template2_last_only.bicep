// param location string
param nicName string = 'testag'
// param tier string = 'testag'
// param skuSize string = 'testag'
// param capacity int = 2
param subnetName string = 'Subnet-1'

param vnet string = 'test-df-vnet'

param resourceGroupName string = 'test-df-bicep'
// param zones array

// @secure()
// param dentons_global_data string

// @secure()
// param dentons_global_password string

// @secure()
// param _3e_prf_wa_http2s_httpCert string

// var vnetId = '/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/network/providers/Microsoft.Network/virtualNetworks/fin91'
// var publicIPRef = ''
// var subnetRef = '${vnetId}/subnets/${subnetName}'
// var applicationGatewayId = resourceId('Microsoft.Network/applicationGateways', applicationGatewayName)


/*
  Create a NIC
*/
resource fin91caprf01_nic_1 'Microsoft.Network/networkInterfaces@2018-10-01' = {
  name: nicName
  properties: {
    provisioningState: 'Succeeded'
    resourceGuid: 'e1a1dabf-49c1-4f71-8792-f625b11de098'
    ipConfigurations: [
      {
        name: 'ipconfig1'
        etag: 'W/"7fd0335e-32c3-46cc-a884-94c9a302a484"'
        // type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          // privateIPAddress: '10.149.135.34'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/${resourceGroupName}/providers/Microsoft.Network/virtualNetworks/${vnet}/subnets/${subnetName}'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          // applicationGatewayBackendAddressPools: [
          //   {
          //     id: '/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/test-davem/providers/Microsoft.Network/applicationGateways/ag-test-df/backendAddressPools/3e-prf-wa-agw-bp'
          //   }
          // ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: [
        '10.154.5.21'
        '10.155.5.21'
      ]
      appliedDnsServers: [
        '10.154.5.21'
        '10.155.5.21'
      ]
      internalDomainNameSuffix: 'jft3tbjqcpkedcgxcoqluasxrh.ux.internal.cloudapp.net'
    }
    macAddress: '00-0D-3A-0C-6E-06'
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    primary: true
    // virtualMachine: {
    //   id: '/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/3E-PERFORMANCE-TEST/providers/Microsoft.Compute/virtualMachines/fin91caprf01'
    // }
    // hostedWorkloads: []
    tapConfigurations: []
  }
  location: resourceGroup().location
  dependsOn: []
}
