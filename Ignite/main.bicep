targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: 'cbezenco-bicep'
  location: deployment().location
}

module appPlanDeploy 'appPlan.bicep' = {
  name: 'appPlanDeploy'
  scope: rg
  params: {
    namePrefix: 'cbezenco'
  }
}
