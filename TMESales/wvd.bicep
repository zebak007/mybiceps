param virtualMachines_vm_wvd_w10_0_name string = 'vm-wvd-w10-0'
param virtualMachines_vm_wvd_w10_1_name string = 'vm-wvd-w10-1'
param workspaces_demo01_name string = 'demo01'
param networkInterfaces_vm_wvd_w10_0_nic_name string = 'vm-wvd-w10-0-nic'
param networkInterfaces_vm_wvd_w10_1_nic_name string = 'vm-wvd-w10-1-nic'
param hostpools_wvd_tmesales_w10_01_name string = 'wvd-tmesales-w10-01'
param applicationgroups_wvd_tmesales_w10_01_DAG_name string = 'wvd-tmesales-w10-01-DAG'
param virtualNetworks_vnet_hub_ne_externalid string = '/subscriptions/be8567b7-fd32-478f-ada5-2df8958c3d55/resourceGroups/TMESALES-HUB/providers/Microsoft.Network/virtualNetworks/vnet-hub-ne'

resource hostpools_wvd_tmesales_w10_01_name_resource 'Microsoft.DesktopVirtualization/hostpools@2021-02-01-preview' = {
  name: hostpools_wvd_tmesales_w10_01_name
  location: 'northeurope'
  properties: {
    description: 'Created through the WVD extension'
    hostPoolType: 'Pooled'
    maxSessionLimit: 5
    loadBalancerType: 'BreadthFirst'
    validationEnvironment: false
    vmTemplate: '{"domain":"tmesales.bezencon.net","galleryImageOffer":"office-365","galleryImagePublisher":"MicrosoftWindowsDesktop","galleryImageSKU":"19h2-evd-o365pp","imageType":"Gallery","imageUri":null,"customImageId":null,"namePrefix":"vm-wvd-w10","osDiskType":"StandardSSD_LRS","useManagedDisks":true,"vmSize":{"id":"Standard_B2s","cores":2,"ram":4},"galleryItemId":"MicrosoftWindowsDesktop.office-36519h2-evd-o365pp"}'
    preferredAppGroupType: 'Desktop'
    startVMOnConnect: false
  }
}

resource workspaces_demo01_name_resource 'Microsoft.DesktopVirtualization/workspaces@2021-02-01-preview' = {
  name: workspaces_demo01_name
  location: 'northeurope'
  properties: {
    applicationGroupReferences: []
  }
}

resource networkInterfaces_vm_wvd_w10_0_nic_name_resource 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: networkInterfaces_vm_wvd_w10_0_nic_name
  location: 'northeurope'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          privateIPAddress: '192.168.15.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${virtualNetworks_vnet_hub_ne_externalid}/subnets/snet-transithub'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

resource networkInterfaces_vm_wvd_w10_1_nic_name_resource 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: networkInterfaces_vm_wvd_w10_1_nic_name
  location: 'northeurope'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          privateIPAddress: '192.168.15.5'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${virtualNetworks_vnet_hub_ne_externalid}/subnets/snet-transithub'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

resource virtualMachines_vm_wvd_w10_0_name_resource 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: virtualMachines_vm_wvd_w10_0_name
  location: 'northeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'office-365'
        sku: '19h2-evd-o365pp'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_wvd_w10_0_name}_OsDisk_1_054f0936402f46c58a6f29addcaff18f'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_wvd_w10_0_name}_OsDisk_1_054f0936402f46c58a6f29addcaff18f')
        }
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_vm_wvd_w10_0_name
      adminUsername: 'cbezenco'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_wvd_w10_0_nic_name_resource.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
    licenseType: 'Windows_Client'
  }
}

resource virtualMachines_vm_wvd_w10_1_name_resource 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: virtualMachines_vm_wvd_w10_1_name
  location: 'northeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'office-365'
        sku: '19h2-evd-o365pp'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_wvd_w10_1_name}_OsDisk_1_9313ef52748349acbc51d6647dbe1d84'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_wvd_w10_1_name}_OsDisk_1_9313ef52748349acbc51d6647dbe1d84')
        }
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_vm_wvd_w10_1_name
      adminUsername: 'cbezenco'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_wvd_w10_1_nic_name_resource.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
    licenseType: 'Windows_Client'
  }
}

resource virtualMachines_vm_wvd_w10_0_name_dscextension 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: '${virtualMachines_vm_wvd_w10_0_name_resource.name}/dscextension'
  location: 'northeurope'
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Powershell'
    type: 'DSC'
    typeHandlerVersion: '2.73'
    settings: {
      modulesUrl: 'https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1-25-2021.zip'
      configurationFunction: 'Configuration.ps1\\AddSessionHost'
      properties: {
        hostPoolName: 'wvd-tmesales-w10-01'
        registrationInfoToken: 'eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2Mjg0QjJDMkE5RTNFRTQxMzdFMTU3RTVFNzhCMzc4M0Y2QzA5NjEiLCJ0eXAiOiJKV1QifQ.eyJSZWdpc3RyYXRpb25JZCI6IjdkN2I2OTA3LWFjOTctNDFkOS1hOTMxLWE4YjAyM2M0NGY4NyIsIkJyb2tlclVyaSI6Imh0dHBzOi8vcmRicm9rZXItZy1ldS1yMC53dmQubWljcm9zb2Z0LmNvbS8iLCJEaWFnbm9zdGljc1VyaSI6Imh0dHBzOi8vcmRkaWFnbm9zdGljcy1nLWV1LXIwLnd2ZC5taWNyb3NvZnQuY29tLyIsIkVuZHBvaW50UG9vbElkIjoiOTM0ZWMwOTQtOTcyNi00YjZkLTk5NTQtOTQ0NTc2ZGJlMzU2IiwiR2xvYmFsQnJva2VyVXJpIjoiaHR0cHM6Ly9yZGJyb2tlci53dmQubWljcm9zb2Z0LmNvbS8iLCJHZW9ncmFwaHkiOiJFVSIsIm5iZiI6MTYxNjYyMzEwMCwiZXhwIjoxNjE2NzA1NTYzLCJpc3MiOiJSREluZnJhVG9rZW5NYW5hZ2VyIiwiYXVkIjoiUkRtaSJ9.BBMteebYtg_qNPadZB8o0rIWsrazMUSqUIL6nUzXzlOEQv5x3WwViP5LJdOSKtOB7N44HziGZAN2DDdLuUHzZswzGY0qIwAgzC8herbWQEMarE3dkrE28wiPO1NPLCsNUFkNnAAJXYE4ShGLm6iEuip5xC_HOYvBNs_RJIQ_cz7BCuYf8AZmcR3CNmaBhjUZECNuJyF7K_7Uuc7AIuOoShA1FElnmuvgOC4exXBpZW3B5tUAUHG-Mn3Rvcerisyx7bIljY-3MKs9U5R3MuaaSaKfr2SORliDVCZalRVTGNwZj6CvLewV_fAlrbTPXReMiAGqi0zUlCI0vTxc1K-HIA'
        aadJoin: false
      }
    }
    protectedSettings: {}
  }
}

resource virtualMachines_vm_wvd_w10_1_name_dscextension 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: '${virtualMachines_vm_wvd_w10_1_name_resource.name}/dscextension'
  location: 'northeurope'
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Powershell'
    type: 'DSC'
    typeHandlerVersion: '2.73'
    settings: {
      modulesUrl: 'https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1-25-2021.zip'
      configurationFunction: 'Configuration.ps1\\AddSessionHost'
      properties: {
        hostPoolName: 'wvd-tmesales-w10-01'
        registrationInfoToken: 'eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2Mjg0QjJDMkE5RTNFRTQxMzdFMTU3RTVFNzhCMzc4M0Y2QzA5NjEiLCJ0eXAiOiJKV1QifQ.eyJSZWdpc3RyYXRpb25JZCI6IjdkN2I2OTA3LWFjOTctNDFkOS1hOTMxLWE4YjAyM2M0NGY4NyIsIkJyb2tlclVyaSI6Imh0dHBzOi8vcmRicm9rZXItZy1ldS1yMC53dmQubWljcm9zb2Z0LmNvbS8iLCJEaWFnbm9zdGljc1VyaSI6Imh0dHBzOi8vcmRkaWFnbm9zdGljcy1nLWV1LXIwLnd2ZC5taWNyb3NvZnQuY29tLyIsIkVuZHBvaW50UG9vbElkIjoiOTM0ZWMwOTQtOTcyNi00YjZkLTk5NTQtOTQ0NTc2ZGJlMzU2IiwiR2xvYmFsQnJva2VyVXJpIjoiaHR0cHM6Ly9yZGJyb2tlci53dmQubWljcm9zb2Z0LmNvbS8iLCJHZW9ncmFwaHkiOiJFVSIsIm5iZiI6MTYxNjYyMzEwMCwiZXhwIjoxNjE2NzA1NTYzLCJpc3MiOiJSREluZnJhVG9rZW5NYW5hZ2VyIiwiYXVkIjoiUkRtaSJ9.BBMteebYtg_qNPadZB8o0rIWsrazMUSqUIL6nUzXzlOEQv5x3WwViP5LJdOSKtOB7N44HziGZAN2DDdLuUHzZswzGY0qIwAgzC8herbWQEMarE3dkrE28wiPO1NPLCsNUFkNnAAJXYE4ShGLm6iEuip5xC_HOYvBNs_RJIQ_cz7BCuYf8AZmcR3CNmaBhjUZECNuJyF7K_7Uuc7AIuOoShA1FElnmuvgOC4exXBpZW3B5tUAUHG-Mn3Rvcerisyx7bIljY-3MKs9U5R3MuaaSaKfr2SORliDVCZalRVTGNwZj6CvLewV_fAlrbTPXReMiAGqi0zUlCI0vTxc1K-HIA'
        aadJoin: false
      }
    }
    protectedSettings: {}
  }
}

resource applicationgroups_wvd_tmesales_w10_01_DAG_name_resource 'Microsoft.DesktopVirtualization/applicationgroups@2021-02-01-preview' = {
  name: applicationgroups_wvd_tmesales_w10_01_DAG_name
  location: 'northeurope'
  kind: 'Desktop'
  properties: {
    hostPoolArmPath: hostpools_wvd_tmesales_w10_01_name_resource.id
    description: 'Desktop Application Group created through the Hostpool Wizard'
    friendlyName: 'Default Desktop'
    applicationGroupType: 'Desktop'
  }
}