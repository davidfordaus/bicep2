// param gatewayName string = 'testag'
param resourceGroupName string = resourceGroup().name
param location string = resourceGroup().location
param applicationGatewayName string
param tier string = 'Standard'
param skuSize string = 'Standard_Small'
param capacity int = 1
param vnetName string = 'testvn6' // eg 'vnet-local'
param subnetName string = 'subnet-0-net' // eg 'subnet1'
// param zones array

// @secure()
// param dentons_global_data string

// @secure()
// param dentons_global_password string

// @secure()
// CERT public data
param _3e_prf_wa_http2s_httpCert string = '''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'''

// param _3e_prf_wa_http2s_httpCert string = '''

// '''

var vnetId = '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Network/virtualNetworks/${vnetName}'
// var publicIPRef = ''
var subnetRef = '${vnetId}/subnets/${subnetName}'
var applicationGatewayId = '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Network/applicationGateways/${applicationGatewayName}'
// /subscriptions/47e915b6-d596-4824-8bd9-47b486986548/resourceGroups/3e-sit2/providers/Microsoft.Network/applicationGateways/3e-sit-wa-agw-02


resource symbolicname 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  name: 'test-keyvault-df/test-cert'
  // tags: {
  //   tagName1: 'tagValue1'
  //   tagName2: 'tagValue2'
  // }
  // parent: resourceSymbolicName
  properties: {
    // attributes: {
    //   enabled: true
    //   exp: int
    //   nbf: int
    // }
    // contentType: 'string'
    // value: 'string'
  }
}


resource applicationGatewayName_resource 'Microsoft.Network/applicationGateways@2021-08-01' = {
  name: applicationGatewayName
  location: location
  // zones: [
    
  // ]
  tags: {
  }
  properties: {
    sku: {
      name: skuSize
      tier: tier
      capacity: capacity
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwPrivateFrontendIp'
        properties: {
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
      {
        name: 'port_443'
        properties: {
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: '3e-prf-wa-agw-bp'
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: '3e-prf-wa-http'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
          connectionDraining: {
            drainTimeoutInSec: 60
            enabled: true
          }
        }
      }
      {
        name: '3e-prf-wa-http2s'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
          authenticationCertificates: [
            {
              // Example
              // id: '${applicationGatewayId}/authenticationCertificates/3e-prf-wa-http2sb65037a0-14d5-428f-8d08-24ae7608d03c'
              // id: '${applicationGatewayId}/authenticationCertificates/authCert'
              id: '/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/test-df-bicep/providers/Microsoft.KeyVault/vaults/test-keyvault-df/certificates/test-cert'
              
            }
          ]
          connectionDraining: {
            drainTimeoutInSec: 60
            enabled: true
          }
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: '3e-prf-wa-http'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGatewayId}/frontendIPConfigurations/appGwPrivateFrontendIp'
          }
          frontendPort: {
            id: '${applicationGatewayId}/frontendPorts/port_80'
          }
          protocol: 'Http'
          // sslCertificate: null
        }
      }
      // {
      //   name: '3e-prf-wa-https'
      //   properties: {
      //     frontendIPConfiguration: {
      //       id: '${applicationGatewayId}/frontendIPConfigurations/appGwPrivateFrontendIp'
      //     }
      //     frontendPort: {
      //       id: '${applicationGatewayId}/frontendPorts/port_443'
      //     }
      //     protocol: 'Https'
      //     sslCertificate: {
      //       id: '${applicationGatewayId}/sslCertificates/dentons.global'
      //     }
      //   }
      // }
    ]
    listeners: []
    requestRoutingRules: [
      {
        name: '3e-prf-wa-http'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: '${applicationGatewayId}/httpListeners/3e-prf-wa-http'
          }
          backendAddressPool: {
            id: '${applicationGatewayId}/backendAddressPools/3e-prf-wa-agw-bp'
          }
          backendHttpSettings: {
            id: '${applicationGatewayId}/backendHttpSettingsCollection/3e-prf-wa-http'
          }
        }
      }
      // {
      //   name: '3e-prf-wa-https'
      //   properties: {
      //     ruleType: 'Basic'
      //     httpListener: {
      //       id: '${applicationGatewayId}/httpListeners/3e-prf-wa-https'
      //     }
      //     backendAddressPool: {
      //       id: '${applicationGatewayId}/backendAddressPools/3e-prf-wa-agw-bp'
      //     }
      //     backendHttpSettings: {
      //       id: '${applicationGatewayId}/backendHttpSettingsCollection/3e-prf-wa-http2s'
      //     }
      //   }
      // }
    ]
    routingRules: []
    enableHttp2: false
    // sslCertificates: [
    //   {
    //     name: 'dentons.global'
    //     properties: {
    //       data: dentons_global_data
    //       password: dentons_global_password
    //     }
    //   }
    // ]
    probes: []
    // authenticationCertificates: [
    //   {
    //     name: 'authCert'
    //     properties: {
    //       // CERT public data
    //       data: _3e_prf_wa_http2s_httpCert
    //       backendHttpSettings: [
    //         {
    //           id: '${applicationGatewayId}/backendHttpSettingsCollection/3e-prf-wa-http2s'
    //         }
    //       ]
    //     }
    //   }
    // ]
  }
  dependsOn: []
}
