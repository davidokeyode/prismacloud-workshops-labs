### Set variables
```
group=myResourceGroup
location=uksouth
vnet=myResourceGroupVNet
```
### Create a resource group
```
az group create --name $group --location $location
```

### Create vNet and subnet
```
az network vnet create -n $vnet -g $group --address-prefix 10.1.0.0/16 --subnet-name vm-subnet --subnet-prefix 10.1.1.0/24
az network vnet subnet create -n aci-subnet --address-prefixes 10.1.2.0/24 -g $group --vnet-name $vnet
```

### Create virtual machine
```
az vm create -g $group -n LinuxVM-webhook --image UbuntuLTS --admin-username azureuser --generate-ssh-keys --vnet-name $vnet --subnet vm-subnet --size Standard_D2s_v3 

az vm extension set -g $group --vm-name LinuxVM-webhook --name customScript --publisher Microsoft.Azure.Extensions   --protected-settings '{"fileUris": ["https://raw.githubusercontent.com/davidokeyode/prismacloud-workshops-labs/main/technotes/templates/linuxpostinstall.sh"],"commandToExecute": "./linuxpostinstall.sh"}'

az vm open-port --port 8084 --resource-group $group --name LinuxVM-webhook
```
### App will be available at http://<IP_ADDRESS>:8084

### Configure webhook integration in Prisma Cloud
* **`Manage`** → **`Alerts`** → **`Manage`** → **`Add profile`**
* **`Name`**: custom-webhook
* **`Provider`**: webhook
* **`Incoming webhook URL`**: http://<IP_ADDRESS>:8084/8d6acddf-9b01-4167-8acc-ea2516c111e2
* **`Alert Triggers`**: Select all 

* Send test alert
* Save

### REFERENCES
* https://hub.docker.com/r/fredsted/webhook.site
* https://github.com/webhooksite/webhook.site/blob/master/docker-compose.yml
* https://docs.webhook.site/open-source.html