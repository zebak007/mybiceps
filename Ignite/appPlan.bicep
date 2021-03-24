param namePrefix string
param sku string = 'B1'

resource myAppPlan 'Microsoft.Web/serverfarms@2020-10-01' = {
  name: '${namePrefix}-appPlan'
  location: resourceGroup().location
  kind: 'linux'
  sku: {
    name: sku
  }
  properties: {
    reserved: true
  }
}

output planID string = myAppPlan.id
