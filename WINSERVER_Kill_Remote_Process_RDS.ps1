#Verify status of 'Remote Desktop Services' in remote computer called SRV-RDS-0
Get-Service -ComputerName SRV-RDS-0 -Name 'TermService'

#Verify ProcessID for the all services with state STOP PENDING in remote computer called SRV-RDS-0
Get-WmiObject -Class win32_service -ComputerName SRV-RDS-0 | Where-Object {$_.state -eq 'stop pending'}

#Kill proccess ID 1288 ir remote computer SRV-RDS-0 with user CONTOSO\Admin
#PSKILL DOC https://docs.microsoft.com/en-us/sysinternals/downloads/pskill
pskill.exe \\AZR-SRV-RDS-0 -u CONTOSO\Admin 1288