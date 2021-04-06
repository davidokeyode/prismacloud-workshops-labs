---
Title: 6 - Deploy Self-Hosted Prisma Cloud Compute (Formerly Twistlock) on Azure RedHat OpenShift (ARO)
Description: Follow these instructions to deploy the Prisma Cloud Compute Security Solution on an Azure RedHat OpenShift (ARO) cluster
Author: David Okeyode
---
# Lesson: Create an Azure Red Hat OpenShift 4 cluster

In this workshop lesson, you will deploy the Prisma Cloud Compute Security Solution on an Azure RedHat OpenShift (ARO) cluster. Here are the tasks that we will be completing in this lesson:

> * Obtain the Prisma Cloud Compute download URL from the Palo Alto Networks Customer Support portal 
> * Deploy the Prisma Cloud Compute Console
> * Deploy Prisma Cloud Defenders
### Obtain the Prisma Cloud Compute download URL from the Palo Alto Networks Customer Support portal
1. Open a web browser and go to [https://support.paloaltonetworks.com](https://support.paloaltonetworks.com). Sign in with your Palo Alto credentials.

2. In the Support portal, go to click on **`Software`** → **`Updates`** → From the drop down list, select **`Prisma Cloud Compute Edition`**  → Open the **`Releases notes PDF`** for the latest version.

![Prisma Cloud Download ](../img/6-pcc-download.png)

3. In the opened **`Releases notes PDF`** document, scroll down to the release information and copy the link information from there. You will need this information later in this exercise.

![Prisma Cloud Download ](../img/6-pcc-download-b.png)

4. Open a browser tab and go the Azure Cloud Shell [https://shell.azure.com](https://shell.azure.com). Sign in with your Azure credentials

5. If you have multiple Azure subscriptions, specify the relevant subscription ID:
    ```
    az account set --subscription <SUBSCRIPTION ID>
    ```
### Deploy the Prisma Cloud Compute Console

1. **Set the following variables in the cloud shell environment**. This will set variables for the cluster name, resource group, location, kubeadmin password, api server URL.
   ```
   LOCATION=uksouth
   RESOURCEGROUP=aro-workshop-rg
   CLUSTER=arocluster

   kubeadminpass=$(az aro list-credentials \
      --name $CLUSTER \
      --resource-group $RESOURCEGROUP \
      --query kubeadminPassword -o tsv)
   
   apiServer=$(az aro show -g $RESOURCEGROUP -n $CLUSTER --query apiserverProfile.url -o tsv)

   ```
2. **Login to the OpenShift cluster's API server using the kubeadmin credentials**
```
oc login $apiServer -u kubeadmin -p $kubeadminpass
```
You should receive a **Login successful** response after running the command

5. Create the twistlock project on the cluster using the following `oc` command:
```
oc new-project twistlock
```

6. Download the Prisma Cloud Compute solution using the command below. Replace the **`<DOWNLOAD_LINK>`** placeholder with the link that you copied earlier. This could take a few minutes to download.
    ```
    curl <DOWNLOAD_LINK> -o pcc.tar.gz 
  
    ```
7. Create a directory and unpack the release tarball to it. The tarball is bundled with different versions of the **`twistcli`** tool (Linux, macOS, and Windows). The twistcli tool is used later to generate YAML files or a Helm chart for deploying Prisma Cloud Compute Console.

   ```   
   mkdir pcc
   tar xvzf pcc.tar.gz -C pcc

   ```

8. Generate the YAML manifest for deploying Prisma Cloud Compute Console. To pull the images from the Prisma Cloud cloud registry, we will specify our access token which is provided as part of our license (Replace the **`<Prisma_Cloud_Access_Token>** placeholder with the actual value). We are also specifying the **`LoadBalancer`** service type for external access.

   ```   
   PRISMACLOUD_ACCESS=<Prisma_Cloud_Access_Token>
   
   cd pcc/

   linux/twistcli console export openshift --registry-token "$PRISMACLOUD_ACCESS" --service-type LoadBalancer

   ``` 
This step results in a YAML file called **`twistlock_console.yaml`** in the current working directory which will be used to deploy the console on ARO.

9. Deploy the console using the command below:
   ``` 
   oc create -f ./twistlock_console.yaml

   oc get project twistlock -w

   oc get svc -n twistlock
   ``` 

10. Obtain the public IP of the console's service using the command below:
   ``` 
   oc get svc -n twistlock
   ``` 
![PCC service ](../img/6-oc-get-console-service.png)

11. Connect to the public IP on port 8083
   ``` 
      https://<public_ip>:8083
   ``` 

12. Create admin username and password

![PCC First Login ](../img/6-pcc-first-login.png)

13. In the **`Manage/System`** window, enter your Prisma Cloud license and click on **`Register`**.

![PCC License ](../img/6-pcc-license.png)


### Deploy Prisma Cloud Compute Defenders

1. **Set the following variables in the cloud shell environment**. This will set variables for the cluster name, resource group, location, kubeadmin password, api server URL.
   ```
   LOCATION=uksouth
   RESOURCEGROUP=aro-workshop-rg
   CLUSTER=arocluster



- https://docs.twistlock.com/docs/compute_edition/install/install_openshift_4.html






## Next steps

In this lesson, you completed the following:
> * Setup the prerequisites required for your Azure environment
> * Create the required virtual network and subnets for the ARO cluster
> * Create the ARO cluster

Proceed to the next lesson:
> [Connect to the ARO cluster](7-connect-aro-cluster.md)
