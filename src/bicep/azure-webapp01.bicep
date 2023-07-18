param location string = resourceGroup().location
param webAppName string = uniqueString(resourceGroup().id)
param skuName string = 'B1'
var appServicePlanName = toLower('AppServicePlan-${webAppName}')


resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }	
  sku: {
    name: skuName
  }
}

resource webApp 'Microsoft.Web/sites@2021-01-01' = {
  name: webAppName
  location: location
  tags: {}
  properties: {
    siteConfig: {
      appSettings: [ {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: 'ZViCGruoLkzqE/o9lqEVidCU7L7e5qwr8W2CT42j8E+ACRDM8IJR'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://biceprg02acr.azurecr.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: 'biceprg02acr'
        }]
      linuxFxVersion: 'DOCKER|biceprg02acr.azurecr.io/nextwebapp:latest'
    }
    serverFarmId: appServicePlan.id
  }
}
