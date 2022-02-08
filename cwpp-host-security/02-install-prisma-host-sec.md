
https://app2.prismacloud.io


Compute -> Manage -> Defenders -> Deploy -> Defenders
Deployment method: Single Defender
Choose the Defender type: 
    Host Defender - Linux
    Host Defender - Windows

Assign globally unique names to Hosts: On


2. **Add custom script extension to install IIS using Azure CLI**
```
az vm extension set -n CustomScriptExtension --publisher Microsoft.Compute --vm-name myWindowsVM1 -g $group --version 1.8 --protected-settings '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}'
```

## Linux
1. **Add custom script extension to install nginx using Azure PowerShell**
```
az vm extension set -g $group --vm-name myLinuxVM1 --name customScript --publisher Microsoft.Azure.Extensions --version 2.1 --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```



