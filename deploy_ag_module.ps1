# az group create --name exampleRG --location eastus

# az deployment group create --resource-group test-df-bicep --template-file template2_last_only.bicep

# Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

Import-Module -Name Az

New-AzResourceGroupDeployment -TemplateFile .\modules\ag_module.bicep `
    -TemplateParameterFile .\modules\ag_module.parameters.json `
    -ResourceGroupName "test-df-bicep"
