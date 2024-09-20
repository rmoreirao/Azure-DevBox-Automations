# References:
# https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-cli

# This command is something you can run to prompt the password for a subscription
#  $env:servicePrincipalPassword =  $(Get-Credential -UserName $env:servicePrincipalId).GetNetworkCredential().Password

az login --service-principal -u $env:servicePrincipalClientId -p $env:servicePrincipalPassword --tenant $env:servicePrincipalTenantId

$scriptsFolder = Get-Location

Set-Location ..\bicep\
Write-Host "Deploying the Dev Center to the Dev Center Subscription"
az account set --subscription $env:devCenterSubscriptionId
az deployment group create --resource-group $env:devCenterResourceGroup --parameters 01_devCenter.bicepparam

Write-Host "Deploying the Project to the Project Subscription"
az account set --subscription $env:projectSubscriptionId
az deployment group create --resource-group $env:projectResourceGroupName --parameters 02_project.Sub02.bicepparam

Set-Location $scriptsFolder