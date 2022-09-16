az group create --name exampleRG --location eastus

az deployment group create --resource-group test-df-bicep --template-file main.bicep --parameters storageName=uniquename