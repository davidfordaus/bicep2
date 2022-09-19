

# Useful pages
https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/application-gateway-key-vault-create


Looks like certs need to be stored as secrets?
https://github.com/andrewatfornax/tech-articles/blob/master/azure-app-gateway-ssl-arm-template.md




# Saving the cert as a secret
```
az keyvault secret set --vault-name KEY_VAULT_NAME --encoding base64 --description text/plain --name CERT_SECRET_NAME --file certificate.pfx
```

Actual command
```
az keyvault secret set --vault-name test-keyvault-df --encoding base64 --description text/plain --name cert --file fiddler_root_normal_pass.pfx
```