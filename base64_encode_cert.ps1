# $Text = ‘This is a secret and should be hidden’
$certFile = Get-Content "test-keyvault-df-test-cert-20220916.pfx" -Raw
$bytes = [System.Text.Encoding]::Unicode.GetBytes($certFile)
$EncodedText =[Convert]::ToBase64String($bytes)
$EncodedText