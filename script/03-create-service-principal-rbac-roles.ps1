# References:
# https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-service-principal

# az login

# Create Service Principal and retrieve details
Write-Host "Creating Service Principal $env:servicePrincipalName"
$env:servicePrincipalPassword = (az ad sp create-for-rbac --name $env:servicePrincipalName --query password --output tsv)

$env:servicePrincipalId = $(az ad sp list --display-name $env:servicePrincipalName --query [].id -o tsv)
$env:servicePrincipalClientId = $(az ad sp list --display-name $env:servicePrincipalName --query [].appId -o tsv)
$env:servicePrincipalTenantId = $(az ad sp list --display-name $env:servicePrincipalName --query [].appOwnerOrganizationId -o tsv)

# Assign the roles to the service principal
Write-Host "Assigning role Contributor to Service Principal $env:servicePrincipalName to the Dev Center resource group $env:devCenterResourceGroup and Project resource group $env:projectResourceGroupName"
az role assignment create --assignee $env:servicePrincipalId --role "Contributor" --resource-group $env:devCenterResourceGroup --subscription $env:devCenterSubscriptionId
az role assignment create --assignee $env:servicePrincipalId --role "Contributor" --resource-group $env:projectResourceGroupName --subscription $env:projectSubscriptionId

# Owner role is required for the Role Assignments in the Project 
Write-Host "Assigning role Owner to Service Principal $env:servicePrincipalName to the Project resource group $env:projectResourceGroupName"
# Alternative is to create a custom role with "Microsoft.Authorization/roleAssignments/write"
az role assignment create --assignee $env:servicePrincipalId --role "Owner" --resource-group $env:projectResourceGroupName --subscription $env:projectSubscriptionId

# Need to assign the role to the network resource group as well - required action: Microsoft.Network/virtualNetworks/subnets/join/action
Write-Host "Assigning role Contributor to Service Principal $env:servicePrincipalName to the Network resource group $env:networkResourceGroupName"
az role assignment create --assignee $env:servicePrincipalId --role "Contributor" --resource-group $env:networkResourceGroupName --subscription $env:networkSubscriptionId
