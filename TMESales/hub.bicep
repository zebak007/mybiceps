param virtualNetworks_vnet_hub_ne_name string = 'vnet-hub-ne'
param networkSecurityGroups_aadds_nsg_externalid string = '/subscriptions/be8567b7-fd32-478f-ada5-2df8958c3d55/resourceGroups/TMESALES-AADDS/providers/Microsoft.Network/networkSecurityGroups/aadds-nsg'

resource virtualNetworks_vnet_hub_ne_name_resource 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: virtualNetworks_vnet_hub_ne_name
  location: 'northeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.168.15.0/24'
      ]
    }
    dhcpOptions: {
      dnsServers: [
        '192.168.15.133'
        '192.168.15.132'
      ]
    }
    subnets: [
      {
        name: 'snet-gateway'
        properties: {
          addressPrefix: '192.168.15.224/27'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'snet-transithub'
        properties: {
          addressPrefix: '192.168.15.0/25'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'snet-aadds'
        properties: {
          addressPrefix: '192.168.15.128/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_aadds_nsg_externalid
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_hub_ne_name_snet_aadds 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${virtualNetworks_vnet_hub_ne_name_resource.name}/snet-aadds'
  properties: {
    addressPrefix: '192.168.15.128/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_aadds_nsg_externalid
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_hub_ne_name_snet_gateway 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${virtualNetworks_vnet_hub_ne_name_resource.name}/snet-gateway'
  properties: {
    addressPrefix: '192.168.15.224/27'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_hub_ne_name_snet_transithub 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${virtualNetworks_vnet_hub_ne_name_resource.name}/snet-transithub'
  properties: {
    addressPrefix: '192.168.15.0/25'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}