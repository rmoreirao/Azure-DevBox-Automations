// To test it: 
// az group create -l westeurope -n rg-devcenter-multisub
// az account set --subscription 91e4cd90-811e-45d3-a068-670b6f14f580
// az deployment group create --resource-group rg-devcenter-multisub  --parameters .\devCenter.bicepparam

using './01_devCenter.bicep'

param DevCenterName = 'DevCenterMultiSub'
param custoImageGalleryName = 'DevBoxImageGallery'
param managedIdentityName = 'MIDevBoxMultiSub'

param definitions = [
  {
    name: 'W11'
    image: 'microsoftwindowsdesktop_windows-ent-cpc_win11-22h2-ent-cpc-os'
    diskSize: 'ssd_512gb'
    vmSKU: 'general_i_8c32gb512ssd_v2'
  }
  {
    name: 'W11_M365'
    image: 'microsoftwindowsdesktop_windows-ent-cpc_win11-22h2-ent-cpc-m365'
    diskSize: 'ssd_512gb'
    vmSKU: 'general_i_8c32gb512ssd_v2'
  }
  {
    name: 'W11_M365_VS2022'
    image: 'microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win11-m365-gen2'
    diskSize: 'ssd_512gb'
    vmSKU: 'general_i_8c32gb512ssd_v2'
  }
]
