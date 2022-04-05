
https://app2.prismacloud.io



    Host Defender - Windows

Assign globally unique names to Hosts: On


### Create deployment script file for Linux
* Compute -> Manage -> Defenders -> Deploy -> Defenders
* Deployment method: Single Defender
* Choose the Defender type: 
  * Host Defender - Linux
  * Copy script

### Copy Linux script to install file
```
Storage -> dostoresec -> prismascripts -> prisma-linux-host-sec-deploy.sh
```
* Modify the file
```
#!/bin/bash

<SCRIPT_GOES_HERE>
```

### Add custom script extension to install Prisma Cloud Host Defender for Linux
```
group=myResourceGroup

az vm extension set -g $group --vm-name myLinuxVM1 --name prisma-host-sec-deploy --publisher Microsoft.Azure.Extensions --version 2.1 --settings '{"fileUris":["https://dostoresec.blob.core.windows.net/prismascripts/prisma-linux-host-sec-deploy.sh"]}' --protected-settings '{"commandToExecute": "./prisma-linux-host-sec-deploy.sh"}'
```


### Create deployment script file for Linux
* Compute -> Manage -> Defenders -> Deploy -> Defenders
* Deployment method: Single Defender
* Choose the Defender type: 
  * Host Defender - Windows
  * Copy script


### Copy windows script to install file
```
Storage -> dostoresec -> prismascripts -> prisma-windows-host-sec-deploy.ps1
```
* Modify the file
```
<SCRIPT_GOES_HERE>
```

### Add custom script extension to install Prisma Cloud Host Defender for Windows
```
group=myResourceGroup

az vm extension set -n CustomScriptExtension --publisher Microsoft.Compute --vm-name myWindowsVM1 -g $group --version 1.8 --settings '{"fileUris":["https://dostoresec.blob.core.windows.net/prismascripts/defender.ps1"]}' --protected-settings '{"commandToExecute": "powershell ./defender.ps1 -type serverWindows -consoleCN us-east1.cloud.twistlock.com -install"}'
```


### Enforce using Azure Policy (DeployIfNotExists)
* https://github.com/Azure/azure-policy/blob/master/samples/Compute/deploy-oms-vm-extension-windows-vm/azurepolicy.rules.json