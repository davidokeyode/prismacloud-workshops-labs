
## Web Hook

### Set variables
```
acrname=acr$RANDOM
group=myResourceGroup
location=uksouth
vnet=myResourceGroupVNet
aci=myaci01
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
az vm create -g $group -n myLinuxVM1 --image UbuntuLTS --admin-username azureuser --generate-ssh-keys --vnet-name $vnet --subnet vm-subnet --size Standard_D2s_v3 

az vm open-port --port 22 --resource-group $group --name myLinuxVM1
```


az vm extension set -g $group --vm-name myLinuxVM1 --name customScript --publisher Microsoft.Azure.Extensions   --protected-settings '{"fileUris": ["https://raw.githubusercontent.com/Microsoft/dotnet-core-sample-templates/master/dotnet-core-music-linux/scripts/config-music.sh"],"commandToExecute": "./linuxpostinstall.sh"}'




* a. Setup webhook debugger
docker pull fredsted/webhook.site

wget https://raw.githubusercontent.com/webhooksite/webhook.site/master/docker-compose.yml

docker-compose up

App will be available at http://127.0.0.1:8084

b. Manage -> Alerts -> Manage -> Add profile
Name: custom-webhook
Provider: webhook
Incoming webhook URL: http://<IP_ADDRESS>:8084/8d6acddf-9b01-4167-8acc-ea2516c111e2
Alert Triggers: Select all 

Send test alert
Save

c. REFERENCES
- https://hub.docker.com/r/fredsted/webhook.site
- https://github.com/webhooksite/webhook.site/blob/master/docker-compose.yml
- https://docs.webhook.site/open-source.html