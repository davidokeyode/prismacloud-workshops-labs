---
Title: 11 - Protect Serverless Container Workloads
Description: Prisma Cloud Compute provides a comprehensive set of security capabilities to protect containerized workloads everywhere including Azure Container Instances and Azure App Services
Author: David Okeyode
---
## Module 11 - Introduction - Protect Serverless Container Workloads

In this module, we will implement protection for ACI workloads. Here's what we'll be completing:

> * Assess Linux and Windows images in the registry for vulnerabilities, malware (static and dymanic) and compliance
> * Assess images in ACR instances with access limited with a firewall, service endpoint, or private endpoints such as Azure Private Link
> * Prevent vulnerable, compromised or non-compliant images from being committed by scanning in your pipelines
> * Prevent untrusted images from being deployed to AKS
> * [Prisma Cloud Windows Containers features](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/install/install_windows.html)

## Module 11 - Exercises

In this module, we will begin to walk through some of the protection capabilities that Prisma Cloud supports for container registries in Azure. Here are the exercises that we will complete:

> * Deploy Sample App to AKS
> * Add Azure Credential in Prisma Cloud
> * Prevent untrusted images from being deployed to AKS
> * Configure protection for Windows pool in AKS
> * Configure and teat ACR webhook integration
> * Troubleshooting ACR Integration

## Exercise 1 - Deploy Sample App to AKS

1. Open a web browser tab and go to the [Azure Cloud Shell](https://shell.azure.com). Sign in with your Azure credentials. Ensure that you are in the **`Bash`** terminal.

2. Configure needed variables. Use the values from **`Module 7 - Exercise 3`**. Replace **`<ACR_NAME>`** with the value of **`ACR Name`** from the output in Module 1.
```
TWISTLOCK_CONSOLE=<PRISMA_CLOUD_CONSOLE_URL>
TWISTLOCK_USER=<PRISMA_CLOUD_ACCESS_KEY_ID>
TWISTLOCK_PASSWORD=<PRISMA_CLOUD_SECRET_KEY>
ACR_NAME=<ACR_NAME>
ACR_LOGIN_SERVER=<ACR_FQDN>
```

3. Run the following commands to embed the Prisma Cloud defender into a Docker file. 

```
wget https://github.com/davidokeyode/cmd_and_kubectl_demos/archive/master.zip
unzip master.zip

# Embed the dockerfile with the app embedded defender
cd ~/
cd cmd_and_kubectl_demos-master/images/pwn_python/

$HOME/pcce/linux/twistcli app-embedded embed -u $TWISTLOCK_USER -p $TWISTLOCK_PASSWORD --address $TWISTLOCK_CONSOLE --app-id "webadmin-aci" --data-folder "/tmp" Dockerfile


```

![twistcli-download](../images/11-app-embed-a.png)

4. Replace the existing dockerfile with the new one that has Prisma Cloud defender embedded by using the commands below:

```
cp Dockerfile Dockerfile.old
rm Dockerfile
unzip app_embedded_embed_webadmin-aci.zip
```

5. Build the container image in the container registry using the commands below.  

```
rm app_embedded_embed_webadmin-aci.zip
rm Dockerfile.old
az acr build --registry $ACR_NAME --image businessapp/webadmin:protected .
```

6. Deploy the container image into ACI with new protected image

```
az acr update -n $ACR_NAME --admin-enabled true

ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --resource-group azlab-rg --query "loginServer" --output tsv)
ACR_USER=$(az acr credential show -n $ACR_NAME --query username --output tsv)
ACR_PASS=$(az acr credential show -n $ACR_NAME --query passwords[0].value --output tsv)

az container create --name azlab-aci --resource-group azlab-rg --image $ACR_LOGIN_SERVER/businessapp/webadmin:protected --registry-login-server $ACR_LOGIN_SERVER --registry-username $ACR_USER --registry-password $ACR_PASS --dns-name-label aci-demo-$RANDOM --query ipAddress.fqdn
```


