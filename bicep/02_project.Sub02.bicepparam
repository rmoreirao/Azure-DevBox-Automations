// To test it:
// az account set --subscription 4c3f03bc-ab2c-4b0a-aa11-9fbc90cc7a58 
// az deployment sub create --location WestEurope  --parameters .\mainProject.Sub02.bicepparam


using './02_project.bicep'

param devCenterSubscriptionID = '91e4cd90-811e-45d3-a068-670b6f14f580'
param devCenterName = 'DevCenterMultiSub'
param devCenterResourceGroupName = 'rg-devcenter-multisub-test-01'

param networkConnectionName = 'VnetSub02-WE-DevBox'
param virtualNetworkSubnetID = '/subscriptions/4c3f03bc-ab2c-4b0a-aa11-9fbc90cc7a58/resourceGroups/rg-devbox-vnet-sub02/providers/Microsoft.Network/virtualNetworks/vn-devbox-sub02/subnets/devbox-subnet-sub02'

param projectName = 'ProjectMultiSub02'
param projectDescription = 'ProjectMultiSub02 Description'
param projectPools = [
  {
    name: 'W11-Pool'
    definitionName: 'W11' // must be the same as the name in the param definitions block
    networkConnectionName: networkConnectionName // must be the same as the networkConnectionName in the networks parameter block
    localAdministrator: 'Enabled'
    stopOnDisconnect: 'Disabled'
    gracePeriodMinutes: 60
    schedule: {
      time: '19:00'
      timeZone: 'Europe/Amsterdam'
    }
  }
  {
    name: 'W11_M365_VS2022-Pool'
    definitionName: 'W11_M365_VS2022' // must be the same as the name in the param definitions block
    networkConnectionName: networkConnectionName // must be the same as the networkConnectionName in the networks parameter block
    localAdministrator: 'Enabled'
    stopOnDisconnect: 'Enabled'
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
