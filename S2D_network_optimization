#Enable Jumpo Frame on Cluster Interfaces ONLY
Get-NetAdapterAdvancedProperty -Name * -RegistryKeyword "*jumbopacket" | Set-NetAdapterAdvancedProperty -RegistryValue 9014
#Create QOS Policy on Cluster Interfaces ONLY
New-NetQosPolicy "SMB" -NetDirectPortMatchCondition 445 -PriorityValue8021Action 3
Enable-NetQosFlowControl -Priority 3
Disable-NetQosFlowControl -Priority 0,1,2,4,5,6,7
Enable-NetAdapterQos -InterfaceAlias "ND02-CLUSTER2"
Enable-NetAdapterQos -InterfaceAlias "ND02-CLUSTER1"
New-NetQosTrafficClass "SMB" -Priority 3 -BandwidthPercentage 30 -Algorithm ETS
