# Corrigir VMs do Azure que não inicializam após update da CrowdStrike
#July 2024

1. Desligue a VM

2. Crie um Reparo de VM a partir do CloudShell

az extension add -n vm-repair
az vm repair create -g MyResourceGroup -n myVM --repair-username adminlocal -repair-password 'password!234' --verbose

3. Acesse a VM via RDPm remova o arquivo do CrowdStrike C-00000291*.sys

4. A partir do CloudShell execute

az vm repair restore -g MyResourceGroup -n MyVM --verbose

5. Ligue a VM

6. Se funcionou, remova o disco original da VM