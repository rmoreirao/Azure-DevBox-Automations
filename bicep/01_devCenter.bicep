// Create the DevCenter and other resources related to the DevCenter directly (not project specific): Image Gallery and DevBox Definitions

targetScope = 'resourceGroup'
param location string = resourceGroup().location

@description('Dev Center Name')
param DevCenterName string

@description('Dev Center User Assigned Managed Identity Name')
param managedIdentityName string

@description('Custom Image Gallery Name')
param custoImageGalleryName string

@description('Array of Image Definitions to be used in Dev Center')
param definitions array

// Dev Center Object
var DevCenter = {
  name: DevCenterName
  definitions: definitions
}


resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' = {
  name: managedIdentityName
  location: location
}

module imageGallery 'modules/CustomImageGallery.bicep' = {
  name: 'ImageGallery'
  params: {
    galleryName : custoImageGalleryName
    location: location
  }
}

// deploy DevCenter
module devCenter 'modules/DevCenter.bicep' = {
  name: 'DevCenter'
  params: {
    location: location
    devCenterName: DevCenter.name
    managedIdentityName: managedIdentityName
    customGalleryName: custoImageGalleryName
  }
  dependsOn: [
    managedIdentity
    imageGallery
  ]
}

// deploy DevCenter builtin images
module devCenterDevBoxDefinitions 'modules/DevCenterDevBoxDefinition.bicep' = [for (definition, i) in DevCenter.definitions: {
  name: 'DeCenterImage${i}'
  params: {
    location: location
    DevCenterDefinitionName: definition.name
    DevCenterGalleryImageName: definition.image
    DevCenterGalleryName: 'Default'
    DevCenterName: devCenter.outputs.Name
    imageSKU: definition.vmSKU
    imageStorageType: definition.diskSize
  }
}]
