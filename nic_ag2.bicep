param location string
param applicationGatewayName string
param tier string
param skuSize string
param capacity int = 2
param subnetName string
param zones array

@secure()
param dentons_global_data string

@secure()
param dentons_global_password string

@secure()
param _3e_prf_wa_http2s_httpCert string

var vnetId = '/subscriptions/47e915b6-d596-4824-8bd9-47b486986548/resourceGroups/network/providers/Microsoft.Network/virtualNetworks/fin91'
var publicIPRef = ''
var subnetRef = '${vnetId}/subnets/${subnetName}'
var applicationGatewayId = resourceId('Microsoft.Network/applicationGateways', applicationGatewayName)

resource fin91caprf01_nic_1 'Microsoft.Network/networkInterfaces@2018-10-01' = {
  name: 'fin91caprf01-nic-1'
  properties: {
    provisioningState: 'Succeeded'
    resourceGuid: 'e1a1dabf-49c1-4f71-8792-f625b11de098'
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '/subscriptions/47e915b6-d596-4824-8bd9-47b486986548/resourceGroups/3e-performance-test/providers/Microsoft.Network/networkInterfaces/fin91caprf01-nic-1/ipConfigurations/ipconfig1'
        etag: 'W/"7fd0335e-32c3-46cc-a884-94c9a302a484"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.149.135.34'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: '/subscriptions/47e915b6-d596-4824-8bd9-47b486986548/resourceGroups/network/providers/Microsoft.Network/virtualNetworks/fin91/subnets/regional-sit'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationGatewayBackendAddressPools: [
            {
              id: '/subscriptions/47e915b6-d596-4824-8bd9-47b486986548/resourceGroups/test-davem/providers/Microsoft.Network/applicationGateways/ag-test-df/backendAddressPools/3e-prf-wa-agw-bp'
            }
          ]
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
    virtualMachine: {
      id: '/subscriptions/47e915b6-d596-4824-8bd9-47b486986548/resourceGroups/3E-PERFORMANCE-TEST/providers/Microsoft.Compute/virtualMachines/fin91caprf01'
    }
    hostedWorkloads: []
    tapConfigurations: []
  }
  location: 'canadacentral'
  dependsOn: []
}