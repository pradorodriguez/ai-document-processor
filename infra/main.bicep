var tenantId = tenant().tenantId
param location string = 'eastus'
param appInsightsLocation string = 'eastus'
param environmentName string = 'dev'
param functionAppName string = 'functionapp-${environmentName}-${uniqueString(resourceGroup().id)}'
param userPrincipalId string = '133c73f8-b870-4c8a-943f-6b45407eb121'

var fileStorageName = 'storage${uniqueString(resourceGroup().id)}'

// Pass resources to functionApp module
module functionApp './modules/functionApp.bicep' = {
  name: 'functionAppModule'
  params: {
    appName: functionAppName
    location: location
    appInsightsLocation: appInsightsLocation
    fileStorageName: fileStorageName
  }
}

// module fileStorage './modules/fileStorage.bicep' = {
//   name: 'fileStorageModule'
//   params: {
//     storageAccountName: fileStorageName
//     location: location
//   }
// }

// module searchService './modules/searchService.bicep' = {
//   name: 'searchServiceModule'
//   params: {
//     searchServiceName: 'searchservice-${uniqueString(resourceGroup().id)}'
//   }
// }

module keyVault './modules/keyVault.bicep' = {
  name: 'keyVaultModule'
  params: {
    vaultName: 'keyvault-${uniqueString(resourceGroup().id)}'
    location: location
    tenantId: tenantId
  }
}

module aoai './modules/aoai.bicep' = {
  name: 'aoaiModule'
}

module functionStorageAccess './modules/rbac/blob-dataowner.bicep' = {
  name: 'functionstorage-access'
  scope: resourceGroup()
  params: {
    resourceName: functionApp.outputs.storageAccountName
    principalID: functionApp.outputs.identityPrincipalId
  }
}

// module fileStorageAccess './modules/rbac/blob-contributor.bicep' = {
//   name: 'blobstorage-access'
//   scope: resourceGroup()
//   params: {
//     resourceName: fileStorage.outputs.name
//     principalId: functionApp.outputs.identityPrincipalId
//   }
// }


resource functionAppContributorRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().subscriptionId, resourceGroup().name, functionApp.name, 'contributor')
  scope: resourceGroup()
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c') // Contributor Role ID
    principalId: userPrincipalId
    principalType: 'User'  // Your User Object ID
  }
}

output RESOURCE_GROUP string = resourceGroup().name
output FUNCTION_APP_NAME string = functionApp.outputs.name
output AZURE_STORAGE_ACCOUNT string = functionApp.outputs.storageAccountName
output FUNCTION_URL string = functionApp.outputs.uri
