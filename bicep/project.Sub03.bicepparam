// To test it:
// az account set --subscription e4c095f5-0fb6-485c-9c13-22f5f97ab428
// az deployment sub create --location WestEurope  --parameters .\mainProject.Sub03.bicepparam


using './project.bicep'

param devCenterSubscriptionID = '91e4cd90-811e-45d3-a068-670b6f14f580'
param devCenterName = 'DevCenterMultiSub'
param devCenterResourceGroupName = 'rg-devcenter-multisub'

param virtualNetworkName = 'VnetSub03-WE-DevBox'
param virtualNetworkSubnetID = '/subscriptions/e4c095f5-0fb6-485c-9c13-22f5f97ab428/resourceGroups/rg-devbox-sub03/providers/Microsoft.Network/virtualNetworks/vn-devbox-sub03/subnets/devbox'

param projectName = 'ProjectMultiSub03'
param projectDescription = 'ProjectMultiSub03 Description'
param projectPools = [
  {
    name: 'W11_M365-Pool'
    definitionName: 'W11_M365' // must be the same as the name in the param definitions block
    networkConnectionName: virtualNetworkName // must be the same as the networkConnectionName in the networks parameter block
    localAdministrator: 'Enabled'
    stopOnDisconnect: 'Disabled'
    gracePeriodMinutes: 60
    schedule: {
      time: '19:00'
      timeZone: 'Europe/Amsterdam'
    }
  }
]

param projectRoleAssignments = [
  {
    roleID: '331c37c6-af14-46d9-b9f4-e1909e1b95a0' // DevCenter Project Admin
    principalID: 'b6f8963a-5e37-4419-a5d9-b2ba562699cd' // User or Group or ServicePrincipal
    principalType: 'User' // User or Group or ServicePrincipal
  }
  {
    roleID: '45d50f46-0b78-4001-a660-4198cbe8cd05' // DevCenter DevBox User
    principalID: 'f74ba1b1-f5e8-4c30-99e5-30dface9d279' // User or Group or ServicePrincipal
    principalType: 'User' // User or Group or ServicePrincipal
  }
]
