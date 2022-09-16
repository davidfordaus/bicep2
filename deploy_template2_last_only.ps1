# az group create --name exampleRG --location eastus

# az deployment group create --resource-group test-df-bicep --template-file template2_last_only.bicep

# Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

Import-Module -Name Az

New-AzResourceGroupDeployment -TemplateFile .\template2_last_only.bicep `
    -TemplateParameterFile .\template2_last_only.parameters.json `
    -ResourceGroupName "test-df-bicep"
