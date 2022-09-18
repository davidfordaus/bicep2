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
// param _3e_prf_wa_http2s_httpCert string

var vnetId = '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Network/virtualNetworks/${vnetName}'
// var publicIPRef = ''
var subnetRef = '${vnetId}/subnets/${subnetName}'
var applicationGatewayId = '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Network/applicationGateways/${applicationGatewayName}'
// /subscriptions/SUBSCRIPTION ID/resourceGroups/3e-sit2/providers/Microsoft.Network/applicationGateways/3e-sit-wa-agw-02
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
      // {
      //   name: 'port_443'
      //   properties: {
      //     port: 443
      //   }
      // }
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
      // {
      //   name: '3e-prf-wa-http2s'
      //   properties: {
      //     port: 443
      //     protocol: 'Https'
      //     cookieBasedAffinity: 'Disabled'
      //     requestTimeout: 20
      //     // authenticationCertificates: [
      //     //   {
      //     //     id: '${applicationGatewayId}/authenticationCertificates/3e-prf-wa-http2sb65037a0-14d5-428f-8d08-24ae7608d03c'
      //     //   }
      //     // ]
      //     connectionDraining: {
      //       drainTimeoutInSec: 60
      //       enabled: true
      //     }
      //   }
      // }
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
          sslCertificate: null
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
    //     name: '3e-prf-wa-http2sb65037a0-14d5-428f-8d08-24ae7608d03c'
    //     properties: {
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
