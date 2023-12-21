# Setup the Certificates Variables

## Specify the name of the new Root CA certificate.
$rootCA_Name = 'TASKTI'

## Specify the Hyper-V server names.
$hostnames = @('HYPER-VREPLICA_FQDN_SERVER_HERE','HYPER-VREPLICA_FQDN_SERVER_HERE')

## What is the password for the exported PFX certificates.
$CertPassword = 'password2024' | ConvertTo-SecureString -Force -AsPlainText

## Where to export the PFX certificate after creating. Make sure that this folder exists.
$CertFolder = 'C:\temp'


$rootCA = New-SelfSignedCertificate `
-Subject $rootCA_Name  `
-FriendlyName $rootCA_Name `
-KeyExportPolicy Exportable  `
-KeyUsage CertSign  `
-KeyLength 2048  `
-KeyUsageProperty All  `
-KeyAlgorithm 'RSA'  `
-HashAlgorithm 'SHA256'  `
-Provider "Microsoft Enhanced RSA and AES Cryptographic Provider"  `
-NotAfter (Get-Date).AddYears(10)

$rootStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("Root","LocalMachine")
$rootStore.Open("ReadWrite")
$rootStore.Add($rootCA)
$rootStore.Close()




## Export the Root CA
$rootCA | Export-PfxCertificate -FilePath "$CertFolder\$($rootCA_Name).pfx" -Password $CertPassword -Force




$hostnames | ForEach-Object {
	$name = $_
	## Create the certificate
	New-SelfSignedCertificate `
	-FriendlyName $name `
	-Subject $name `
	-KeyExportPolicy Exportable `
	-CertStoreLocation "Cert:\LocalMachine\My" `
	-Signer $rootCA `
	-KeyLength 2048  `
	-KeyAlgorithm 'RSA'  `
	-HashAlgorithm 'SHA256'  `
	-Provider "Microsoft Enhanced RSA and AES Cryptographic Provider"  `
	-NotAfter (Get-Date).AddYears(10) |
	## Export the certificate
	Export-PfxCertificate -FilePath "$CertFolder\$($name).pfx" -Password $CertPassword -Force
}


## Disable Certificate Revocation Check
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Replication" -Name "DisableCertRevocationCheck" -Value 1 -PropertyType DWORD -Force




=======

## Acicionar no servidor Replica

## Specify the name of the Root CA certificate.
$rootCA_Name = 'TASKTI'

## Where to find the PFX certificate files.
$CertFolder = 'C:\temp'

## What is the password for the exported PFX certificates.
$CertPassword = 'password2024' | ConvertTo-SecureString -Force -AsPlainText

## Import the Root CA
Import-PfxCertificate  "$CertFolder\$($rootCA_Name).pfx" -CertStoreLocation Cert:\LocalMachine\Root -Password $CertPassword


Import-PfxCertificate  "$CertFolder\FQDN_NAME_CERTIFICATE.pfx" -CertStoreLocation Cert:\LocalMachine\My -Password $CertPassword

## Disable Certificate Revocation Check
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Replication" -Name "DisableCertRevocationCheck" -Value 1 -PropertyType DWORD -Force