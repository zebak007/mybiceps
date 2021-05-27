param networkSecurityGroups_aadds_nsg_name string = 'aadds-nsg'
param domainServices_tmesales_bezencon_net_name string = 'tmesales.bezencon.net'
param loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name string = 'aadds-da71415dbf4b4edb8ee991c5772f60d5-lb'
param networkInterfaces_aadds_24ca7fc51860464686968411e0cb3300_nic_name string = 'aadds-24ca7fc51860464686968411e0cb3300-nic'
param networkInterfaces_aadds_2ad43a563d5144f0ae941a589e2f8563_nic_name string = 'aadds-2ad43a563d5144f0ae941a589e2f8563-nic'
param publicIPAddresses_aadds_da71415dbf4b4edb8ee991c5772f60d5_pip_name string = 'aadds-da71415dbf4b4edb8ee991c5772f60d5-pip'
param virtualNetworks_vnet_hub_ne_externalid string = '/subscriptions/be8567b7-fd32-478f-ada5-2df8958c3d55/resourceGroups/TMESALES-HUB/providers/Microsoft.Network/virtualNetworks/vnet-hub-ne'

resource domainServices_tmesales_bezencon_net_name_resource 'Microsoft.AAD/domainServices@2020-01-01' = {
  name: domainServices_tmesales_bezencon_net_name
  location: 'northeurope'
  properties: {
    domainName: domainServices_tmesales_bezencon_net_name
    replicaSets: [
      {
        location: 'North Europe'
        subnetId: '${virtualNetworks_vnet_hub_ne_externalid}/subnets/snet-aadds'
      }
    ]
    ldapsSettings: {
      ldaps: 'Disabled'
      externalAccess: 'Disabled'
    }
    domainSecuritySettings: {
      ntlmV1: 'Enabled'
      tlsV1: 'Enabled'
      syncNtlmPasswords: 'Enabled'
      syncKerberosPasswords: 'Enabled'
      syncOnPremPasswords: 'Enabled'
    }
    filteredSync: 'Disabled'
    resourceForestSettings: {
      settings: []
    }
    domainConfigurationType: 'FullySynced'
    notificationSettings: {
      notifyGlobalAdmins: 'Enabled'
      notifyDcAdmins: 'Enabled'
      additionalRecipients: []
    }
    sku: 'Standard'
  }
}

resource networkSecurityGroups_aadds_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  name: networkSecurityGroups_aadds_nsg_name
  location: 'northeurope'
  properties: {
    securityRules: [
      {
        name: 'AllowPSRemoting'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '5986'
          sourceAddressPrefix: 'AzureActiveDirectoryDomainServices'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 301
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'AllowRD'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: 'CorpNetSaw'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 201
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_aadds_da71415dbf4b4edb8ee991c5772f60d5_pip_name_resource 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: publicIPAddresses_aadds_da71415dbf4b4edb8ee991c5772f60d5_pip_name
  location: 'northeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    ipAddress: '20.67.178.126'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    dnsSettings: {
      domainNameLabel: 'cust-t-m-e-s-a-l-e-s-0-b-e-da71415d-bf4b-4edb-8ee9-91c5772f60d5'
      fqdn: 'cust-t-m-e-s-a-l-e-s-0-b-e-da71415d-bf4b-4edb-8ee9-91c5772f60d5.northeurope.cloudapp.azure.com'
    }
    ipTags: []
  }
}

resource loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_D30TU3_BF5MKDB8Be 'Microsoft.Network/loadBalancers/backendAddressPools@2020-08-01' = {
  name: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.name}/D30TU3-BF5MKDB8Be'
  properties: {
    loadBalancerBackendAddresses: [
      {
        name: 'TMESALES-AADDS_aadds-2ad43a563d5144f0ae941a589e2f8563-nicG5630ZI4HWNFKJUIpcfg'
        properties: {}
      }
      {
        name: 'TMESALES-AADDS_aadds-24ca7fc51860464686968411e0cb3300-nicJQGCJEKMX4TJMFKIpcfg'
        properties: {}
      }
    ]
  }
}

resource loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_G5630ZI4HWNFKJUPsh 'Microsoft.Network/loadBalancers/inboundNatRules@2020-08-01' = {
  name: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.name}/G5630ZI4HWNFKJUPsh'
  properties: {
    frontendIPConfiguration: {
      id: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.id}/frontendIPConfigurations/D30TU3-BF5MKDB8Fe'
    }
    frontendPort: 5986
    backendPort: 5986
    enableFloatingIP: false
    idleTimeoutInMinutes: 15
    protocol: 'Tcp'
    enableTcpReset: false
  }
}

resource loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_JQGCJEKMX4TJMFKPsh 'Microsoft.Network/loadBalancers/inboundNatRules@2020-08-01' = {
  name: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.name}/JQGCJEKMX4TJMFKPsh'
  properties: {
    frontendIPConfiguration: {
      id: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.id}/frontendIPConfigurations/D30TU3-BF5MKDB8Fe'
    }
    frontendPort: 5987
    backendPort: 5986
    enableFloatingIP: false
    idleTimeoutInMinutes: 15
    protocol: 'Tcp'
    enableTcpReset: false
  }
}

resource networkSecurityGroups_aadds_nsg_name_AllowPSRemoting 'Microsoft.Network/networkSecurityGroups/securityRules@2020-08-01' = {
  name: '${networkSecurityGroups_aadds_nsg_name_resource.name}/AllowPSRemoting'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '5986'
    sourceAddressPrefix: 'AzureActiveDirectoryDomainServices'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 301
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_aadds_nsg_name_AllowRD 'Microsoft.Network/networkSecurityGroups/securityRules@2020-08-01' = {
  name: '${networkSecurityGroups_aadds_nsg_name_resource.name}/AllowRD'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: 'CorpNetSaw'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 201
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource 'Microsoft.Network/loadBalancers@2020-08-01' = {
  name: loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name
  location: 'northeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'D30TU3-BF5MKDB8Fe'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_aadds_da71415dbf4b4edb8ee991c5772f60d5_pip_name_resource.id
          }
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'D30TU3-BF5MKDB8Be'
        properties: {
          loadBalancerBackendAddresses: [
            {
              name: 'TMESALES-AADDS_aadds-2ad43a563d5144f0ae941a589e2f8563-nicG5630ZI4HWNFKJUIpcfg'
              properties: {}
            }
            {
              name: 'TMESALES-AADDS_aadds-24ca7fc51860464686968411e0cb3300-nicJQGCJEKMX4TJMFKIpcfg'
              properties: {}
            }
          ]
        }
      }
    ]
    loadBalancingRules: []
    probes: []
    inboundNatRules: [
      {
        name: 'G5630ZI4HWNFKJUPsh'
        properties: {
          frontendIPConfiguration: {
            id: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.id}/frontendIPConfigurations/D30TU3-BF5MKDB8Fe'
          }
          frontendPort: 5986
          backendPort: 5986
          enableFloatingIP: false
          idleTimeoutInMinutes: 15
          protocol: 'Tcp'
          enableTcpReset: false
        }
      }
      {
        name: 'JQGCJEKMX4TJMFKPsh'
        properties: {
          frontendIPConfiguration: {
            id: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.id}/frontendIPConfigurations/D30TU3-BF5MKDB8Fe'
          }
          frontendPort: 5987
          backendPort: 5986
          enableFloatingIP: false
          idleTimeoutInMinutes: 15
          protocol: 'Tcp'
          enableTcpReset: false
        }
      }
    ]
    outboundRules: [
      {
        name: 'D30TU3-BF5MKDB8Ge'
        properties: {
          allocatedOutboundPorts: 1024
          protocol: 'Tcp'
          enableTcpReset: false
          idleTimeoutInMinutes: 4
          backendAddressPool: {
            id: loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_D30TU3_BF5MKDB8Be.id
          }
          frontendIPConfigurations: [
            {
              id: '${loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_resource.id}/frontendIPConfigurations/D30TU3-BF5MKDB8Fe'
            }
          ]
        }
      }
    ]
    inboundNatPools: []
  }
}

resource networkInterfaces_aadds_24ca7fc51860464686968411e0cb3300_nic_name_resource 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: networkInterfaces_aadds_24ca7fc51860464686968411e0cb3300_nic_name
  location: 'northeurope'
  properties: {
    ipConfigurations: [
      {
        name: 'JQGCJEKMX4TJMFKIpcfg'
        properties: {
          privateIPAddress: '192.168.15.133'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${virtualNetworks_vnet_hub_ne_externalid}/subnets/snet-aadds'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          loadBalancerBackendAddressPools: [
            {
              id: loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_D30TU3_BF5MKDB8Be.id
            }
          ]
          loadBalancerInboundNatRules: [
            {
              id: loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_JQGCJEKMX4TJMFKPsh.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: [
        '192.168.15.132'
        '192.168.15.133'
      ]
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

resource networkInterfaces_aadds_2ad43a563d5144f0ae941a589e2f8563_nic_name_resource 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: networkInterfaces_aadds_2ad43a563d5144f0ae941a589e2f8563_nic_name
  location: 'northeurope'
  properties: {
    ipConfigurations: [
      {
        name: 'G5630ZI4HWNFKJUIpcfg'
        properties: {
          privateIPAddress: '192.168.15.132'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${virtualNetworks_vnet_hub_ne_externalid}/subnets/snet-aadds'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          loadBalancerBackendAddressPools: [
            {
              id: loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_D30TU3_BF5MKDB8Be.id
            }
          ]
          loadBalancerInboundNatRules: [
            {
              id: loadBalancers_aadds_da71415dbf4b4edb8ee991c5772f60d5_lb_name_G5630ZI4HWNFKJUPsh.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: [
        '192.168.15.132'
        '192.168.15.133'
      ]
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}