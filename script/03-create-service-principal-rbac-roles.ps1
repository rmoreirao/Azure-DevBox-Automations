# References:
# https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-service-principal

# az login

# Create Service Principal and retrieve details
Write-Host "Delete Service Principal $env:servicePrincipalName"
az ad sp delete --id $(az ad sp list --display-name $env:servicePrincipalName --query [].appId -o tsv)

Write-Host "Creating Service Principal $env:servicePrincipalName"
$env:servicePrincipalPassword = (az ad sp create-for-rbac --name $env:servicePrincipalName --query password --output tsv)

$env:servicePrincipalId = $(az ad sp list --display-name $env:servicePrincipalName --query [].id -o tsv)
$env:servicePrincipalClientId = $(az ad sp list --display-name $env:servicePrincipalName --query [].appId -o tsv)
$env:servicePrincipalTenantId = $(az ad sp list --display-name $env:servicePrincipalName --query [].appOwnerOrganizationId -o tsv)

# Assign the roles to the service principal
Write-Host "Assigning role Owner to Service Principal $env:servicePrincipalName to the Dev Center resource group $env:devCenterResourceGroup"
az role assignment create --assignee $env:servicePrincipalId --role "Owner" --scope "/subscriptions/$env:devCenterSubscriptionId/resourceGroups/$env:devCenterResourceGroup"

Write-Host "Assigning role Owner to Service Principal $env:servicePrincipalName to the Project resource group $env:projectResourceGroupName"
az role assignment create --assignee $env:servicePrincipalId --role "Owner" --scope "/subscriptions/$env:projectSubscriptionId/resourceGroups/$env:projectResourceGroupName"

# Owner role is required for the Role Assignments in the Project 
Write-Host "Assigning role Owner to Service Principal $env:servicePrincipalName to the Project resource group $env:projectResourceGroupName"
az role assignment create --assignee $env:servicePrincipalId --role "Owner" --scope "/subscriptions/$env:projectSubscriptionId/resourceGroups/$env:projectResourceGroupName"

# Need to assign the role to the network resource group as well - required action: Microsoft.Network/virtualNetworks/subnets/join/action
Write-Host "Assigning role Contributor to Service Principal $env:servicePrincipalName to the Network resource group $env:networkResourceGroupName"
az role assignment create --assignee $env:servicePrincipalId --role "Contributor" --scope "/subscriptions/$env:networkSubscriptionId/resourceGroups/$env:networkResourceGroupName"