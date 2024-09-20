param galleryName string
param location string
// param galleryManagedIdentityName string
// var templateRoleDefinitionName = guid(resourceGroup().id)

// resource templateIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' = {
//   name: galleryManagedIdentityName
//   location: location
// }

resource computeGallery 'Microsoft.Compute/galleries@2022-03-03' = {
  name: galleryName
  location: location
}

// resource templateRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
//   name: templateRoleDefinitionName
//   properties: {
//     roleName: templateRoleDefinitionName
//     description: 'Image Builder access to create resources for the image build, you should delete or split out as appropriate'
//     type: 'customRole'
//     permissions: [
//       {
//         actions: [
//           'Microsoft.Compute/galleries/read'
//           'Microsoft.Compute/galleries/images/read'
//           'Microsoft.Compute/galleries/images/versions/read'
//           'Microsoft.Compute/galleries/images/versions/write'
//           'Microsoft.Compute/images/write'
//           'Microsoft.Compute/images/read'
//           'Microsoft.Compute/images/delete'
//           'Microsoft.Storage/storageAccounts/blobServices/containers/read'
//           'Microsoft.Storage/storageAccounts/blobServices/containers/write'
//           'Microsoft.Resources/deployments/read'
//           'Microsoft.Resources/deploymentScripts/read'
//           'Microsoft.Resources/deploymentScripts/write'
//           'Microsoft.VirtualMachineImages/imageTemplates/run/action'
//           'Microsoft.ContainerInstance/containerGroups/read'
//           'Microsoft.ContainerInstance/containerGroups/write'
//           'Microsoft.ContainerInstance/containerGroups/start/action'
//         ]
//       }
//     ]
//     assignableScopes: [
//       resourceGroup().id
//     ]
//   }
// }

// resource templateRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
//   name: guid(resourceGroup().id, '${templateRoleDefinition.id}', templateIdentity.id)
//   properties: {
//     roleDefinitionId: templateRoleDefinition.id
//     principalId: templateIdentity.properties.principalId
//     principalType: 'ServicePrincipal'
//   }
// }
