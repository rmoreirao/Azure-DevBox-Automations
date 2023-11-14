# az login

Write-Host "Destroying resources in $env:devCenterResourceGroup"
az account set --subscription $env:devCenterSubscriptionId
az group delete -n $env:devCenterResourceGroup --yes

Write-Host "Destroying resources in $env:projectResourceGroupName"
az account set --subscription $env:projectSubscriptionId
az group delete -n $env:projectResourceGroupName --yes

Write-Host "Destroying resources in $env:networkResourceGroupName"
az account set --subscription $env:networkSubscriptionId
az group delete -n $env:networkResourceGroupName --yes

Write-Host "Destroying Service Principal $env:servicePrincipalName"
az ad sp delete --id $env:servicePrincipalId