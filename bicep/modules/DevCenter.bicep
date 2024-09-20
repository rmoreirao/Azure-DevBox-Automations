param location string
param devCenterName string
param managedIdentityName string
param customGalleryName string

// DevCenter Dev Box User role 

// Roles required for the Compute Gallery
var CONTRIBUTOR_ROLE = 'b24988ac-6180-42a0-ab88-20f7382dd24c'
var READER_ROLE = 'acdd72a7-3385-48ef-bd42-f606fba81ae7'
// Used when Dev Center associate with Azure Compute Gallery
var WINDOWS365_PRINCIPALID = '8eec7c09-06ae-48e9-aafd-9fb31a5d5175'

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
  name: managedIdentityName
}

// Deploy DevCenter
resource devCenter 'Microsoft.DevCenter/devcenters@2023-04-01' = {
  name: devCenterName
  location: location
  identity: {
    type:  'UserAssigned'
     userAssignedIdentities: {
      '${managedIdentity.id}': {}
     }
  }
}

resource computeGallery 'Microsoft.Compute/galleries@2022-03-03' existing = {
  name: customGalleryName
}

resource contirbutorGalleryRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, resourceGroup().id, managedIdentity.id, CONTRIBUTOR_ROLE)
  scope: computeGallery
  properties: {
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', CONTRIBUTOR_ROLE)
  }
}

resource readGalleryRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, resourceGroup().id, WINDOWS365_PRINCIPALID, READER_ROLE)
  scope: computeGallery
  properties: {
    principalId: WINDOWS365_PRINCIPALID
    principalType: 'ServicePrincipal'
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', READER_ROLE)
  }
}

resource devcenterGallery 'Microsoft.DevCenter/devcenters/galleries@2023-01-01-preview' = {
  name: customGalleryName
  parent: devCenter
  properties: {
    galleryResourceId: computeGallery.id
  }
  dependsOn: [
    readGalleryRole
    contirbutorGalleryRole
  ]
}

output Id string = devCenter.id
output Name string = devCenter.name
