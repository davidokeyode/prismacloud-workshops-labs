
### Set variables
```
group=myResourceGroup
location=westeurope
vnet=$location-vnet
```
### Create a resource group
```
az group create --name $group --location $location
```

### Create vNet and subnet
```
az network vnet create -n $vnet -g $group --address-prefix 10.1.0.0/16 --subnet-name vm-subnet --subnet-prefix 10.1.1.0/24
```

### Create Linux VM
```
az vm create -g $group -n myLinuxVM1 --image UbuntuLTS --admin-username azureuser --admin-password awrZzD9DJmKKXsJa --vnet-name $vnet --subnet vm-subnet --size Standard_D2s_v3 

az vm open-port --port 22 --resource-group $group --name myLinuxVM1
```

### Create Windows VM
```
az vm create -g $group -n myWindowsVM1 --image Win2019Datacenter --admin-username azureuser --admin-password awrZzD9DJmKKXsJa --vnet-name $vnet --subnet vm-subnet --size Standard_D4s_v3 --public-ip-sku Standard

az vm open-port --port 3389 --resource-group $group --name myWindowsVM1
```