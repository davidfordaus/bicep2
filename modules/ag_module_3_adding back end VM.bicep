// param gatewayName string = 'testag'
param resourceGroupName string = resourceGroup().name
param location string = resourceGroup().location
param applicationGatewayName string
param tier string = 'Standard'
param skuSize string = 'Standard_Small'
param capacity int = 1
param vnetName string = 'testvn6' // eg 'vnet-local'
param subnetName string = 'subnet-0-net' // eg 'subnet1'
param privateIPAddress string

@description('The base-64 encoded SSL certificate PFX data. Must be supplied via a parameters file references to a Key Vault / Secret Name.')
param sslCertificateData string

@description('The SSL certificate password. Must be supplied via a parameters file references to a Key Vault / Secret Name')
@secure()
param sslCertificatePassword string


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
// /subscriptions/47e915b6-d596-4824-8bd9-47b486986548/resourceGroups/3e-sit2/providers/Microsoft.Network/applicationGateways/3e-sit-wa-agw-02
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
          privateIPAddress: privateIPAddress
          privateIPAllocationMethod: 'Static'
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
        name:'backend-pool'
        properties: {
          backendAddresses: [
            {
              ipAddress: '10.0.0.5'
            }
          ]
        }
        // id: '/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/test-df-bicep/providers/Microsoft.Network/networkInterfaces/test-ag-machine1187_z1/ipConfigurations/ipconfig1'
      }
      // {
      //   name: '3e-prf-wa-agw-bp'
      //   properties: {
          
      //     backendAddresses: [
      //       {
      //         ipAddress: '/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/test-df-bicep/providers/Microsoft.Network/networkInterfaces/test-ag-machine1187_z1/ipConfigurations/ipconfig1'
      //       }
      //     //   "backendIPConfigurations": [
      //     //     {
      //     //         "id": "/subscriptions/a1df2b46-08c4-4d8a-b078-6beb5047606b/resourceGroups/test-df-bicep/providers/Microsoft.Network/networkInterfaces/test-ag-machine1187_z1/ipConfigurations/ipconfig1"
      //     //     }
      //     // ],

      //     ]
      //   }
      // }
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
        name: '3e-prf-wa-https'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
          // authenticationCertificates: [
          //   {
          //     id: '${applicationGatewayId}/authenticationCertificates/3e-prf-wa-http2sb65037a0-14d5-428f-8d08-24ae7608d03c'
          //   }
          // ]
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
          sslCertificate: null
        }
      }
      {
        name: '3e-prf-wa-https'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGatewayId}/frontendIPConfigurations/appGwPrivateFrontendIp'
          }
          frontendPort: {
            id: '${applicationGatewayId}/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: '${applicationGatewayId}/sslCertificates/frontendCert'
          }
        }
      }
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
            id: '${applicationGatewayId}/backendAddressPools/backend-pool'
          }
          backendHttpSettings: {
            id: '${applicationGatewayId}/backendHttpSettingsCollection/3e-prf-wa-http'
          }
        }
      }
      {
        name: '3e-prf-wa-https'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: '${applicationGatewayId}/httpListeners/3e-prf-wa-https'
          }
          backendAddressPool: {
            id: '${applicationGatewayId}/backendAddressPools/backend-pool'
          }
          backendHttpSettings: {
            // TODO this should be 3e-prf-wa-https  HTTPS
            id: '${applicationGatewayId}/backendHttpSettingsCollection/3e-prf-wa-https'
          }
        }
      }
    ]
    routingRules: []
    enableHttp2: false

    sslCertificates: [
      {
        name: 'frontendCert'
        properties: {
          data: sslCertificateData
          password: sslCertificatePassword
        }
      }
    ]

  //   "sslCertificates": [
  //     {
  //         "name": "appGwSslCertificate",
  //         "properties": {
  //             "data": "[parameters('sslCertificateData')]",
  //             "password": "[parameters('sslCertificatePassword')]"
  //         }
  //     }
  // ],

    probes: [
      // Probe loads correctly but breaks the AG
      {
        name: 'http-probe'
        properties:{
          host: '127.0.0.1'
          interval: 10 // TODO  SHOULD BE 30.  Set low for testing
          timeout: 30
          path: '/'
          // port: 80  // Small SKU doesn't permit a port; it's 80 by default for protocol Http
          protocol: 'Http'
        }
      }
    ]
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
