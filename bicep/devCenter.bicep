// Create the DevCenter and other resources related to the DevCenter directly (not project specific): Image Gallery and DevBox Definitions

targetScope = 'resourceGroup'
param location string = resourceGroup().location

@description('Dev Center Name')
param DevCenterName string


@description('Array of Image Definitions to be used in Dev Center')
param definitions array

// Dev Center Object
var DevCenter = {
  name: DevCenterName
  definitions: definitions
}

// deploy DevCenter
module devCenter 'modules/DevCenter.bicep' = {
  name: 'DevCenter'
  params: {
    location: location
    devCenterName: DevCenter.name
  }
}

// deploy DevCenter builtin images
module devCenterBuiltinImages 'modules/DevCenterImage.bicep' = [for (definition, i) in DevCenter.definitions: {
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
