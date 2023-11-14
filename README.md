# Azure DevBox Automations
Objective is to show how you could implement automations around Provisioning DevBox, including RBAC roles

## Scenario:
- Deploy DevBox via IaC using bicep templates
- 1) mainDevCenter.bicep: Deploy the DevCenter and all related resources: Image Gallery and DevBox Definitions
- 2) mainProject.bicep: Deploy the Project and Specific Resources: Project, Project Role Assignments, Network Connection and DevBox Pools

# References:
- This repo used the scripts from repo: https://github.com/PieterbasNagengast/Azure-DevBox
- test