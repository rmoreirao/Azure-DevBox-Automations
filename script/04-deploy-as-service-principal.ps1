# References:
# https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-cli

if ($null -eq $env:servicePrincipalPassword) {
    $env:servicePrincipalPassword =  (Get-Credential -UserName $env:servicePrincipalId).GetNetworkCredential().Password
}

if ($null -eq $env:servicePrincipalPassword) {
    throw "Failed to get credentials"
}

az login --service-principal -u $env:servicePrincipalClientId -p $env:servicePrincipalPassword --tenant $env:servicePrincipalTenantId

$scriptsFolder = Get-Location

Set-Location ..\bicep\
# Deploy the Dev Center to DevCenter Subscription
# az account set --subscription $env:devCenterSubscriptionId
# az deployment group create --resource-group $env:devCenterResourceGroup --parameters devCenter.bicepparam

# Deploy the Dev Center to DevCenter Subscription
az account set --subscription $env:projectSubscriptionId
az deployment group create --resource-group $env:projectResourceGroupName --parameters project.Sub02.bicepparam

Set-Location $scriptsFolder