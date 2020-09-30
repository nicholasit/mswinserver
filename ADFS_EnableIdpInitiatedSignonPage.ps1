Get-AdfsProperties | Select-Object EnableIdpInitiatedSignonpage
Set-AdfsProperties -EnableIdpInitiatedSignonPage $True