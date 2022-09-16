param location string = resourceGroup().location
/** 
* some doco on this parameter
*/
param vnetName string // eg testVnet
param subnetNumber int // example : 3 subnets
param addressPrefix string // example : 10.0.0.0/16
param subnetPrefix string // name prefix of the subnet - eg 'subnet'

module vnet 'modules/vnet_module.bicep' = {
  name: 'dep1'
  params: {
    location:location
    vnetName:vnetName
    subnetNumber:subnetNumber
    addressPrefix:addressPrefix
    subnetPrefix:subnetPrefix
  }
}

module nic 'modules/nic_module.bicep' = {
  dependsOn: [
    vnet
  ]
  name: 'nic1'
  params: {
    name: 'nic1'
    vnetName:vnetName
    subnetName: 'subnet-0-net'
  }
}
