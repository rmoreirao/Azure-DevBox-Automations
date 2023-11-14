# az login

# Create the Dev Center Resource Group
Write-Host "Creating Dev Center resource group $env:devCenterResourceGroup"
az account set --subscription $env:devCenterSubscriptionId
az group create -l $env:region -n $env:devCenterResourceGroup

# Create the Projects Resource Group
Write-Host "Creating Project resource group $env:projectResourceGroupName"
az account set --subscription $env:projectSubscriptionId
az group create -l $env:region -n $env:projectResourceGroupName

# Create the Netowrks Resource Group
Write-Host "Creating Network resource group $env:networkResourceGroupName"
az account set --subscription $env:networkSubscriptionId
az group create -l $env:region -n $env:networkResourceGroupName

# Create the Virtual Network and subnet
Write-Host "Creating Virtual Network $env:networkVNetName and subnet $env:networkSubnetName"
az network vnet create `
    --name $env:networkVNetName `
    --resource-group $env:networkResourceGroupName `
    --address-prefixes 10.0.0.0/16 `
    --subnet-name $env:networkSubnetName `
    --subnet-prefixes 10.0.0.0/24
