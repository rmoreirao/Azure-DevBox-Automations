# TODO:
- Create a Clean Up Script

# Azure DevBox Automations
Objective is to show how you could implement automations around Provisioning DevBox, including RBAC roles

## Pre Reqs
- Have VNet and SubNet for each Project

## Generic Scenario:
- Deploy DevBox via IaC using bicep templates
- 1) mainDevCenter.bicep: Deploy the DevCenter and all related resources: Image Gallery and DevBox Definitions
- 2) mainProject.bicep: Deploy the Project and Specific Resources: Project, Project Role Assignments, Network Connection and DevBox Pools

## Execute from a Service Principal
- Have a Service Principal created
### To run the commands as a Service Principal
https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-service-principal
- Grant Service Principal the following access permissions:
    
| Responsibilities / Actions            | Subscription       | RBAC Role            | Scope                                                  |
| ------------------------------------- | ------------------ | -------------------- | ------------------------------------------------------ |
| Create and Manage the DevCenter (also, DevBox defition, Add / Remove Project from DevCenter and Attach Network Connection)   | DevCenter Subscription | Owner or Contributor | IT4IT Subscription or DevCenter Resource Group         |
| Create and Manage the Network Connections | VNet Subscription | Owner or Contributor | VNet Subscription or Resource Group |
| Attach / Remove Network Connection to a Dev Center | DevCenter Subscription  | Owner or Contributor | DevCenter Subscription, Resource Group or Resource |
| Create or Delete DevBox Project | DevCenter and Project Subscriptions  | Owner or Contributor | Subscription, Resource Group or Resource |

# References:
- This repo used the scripts from repo: https://github.com/PieterbasNagengast/Azure-DevBox
- DevBox documentation for Permissions: https://learn.microsoft.com/en-us/azure/dev-box/ 
- Bicep docs: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-to-resource-group?tabs=azure-cli


