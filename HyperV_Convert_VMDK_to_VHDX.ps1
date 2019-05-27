Import-Module 'C:\Program Files\Microsoft Virtual Machine Converter\MvmcCmdlet.psd1'
ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath C:\vm\disco_vmware.vmdk -VhdType DynamicHardDisk -VhdFormat vhdx -destination c:\vm\
