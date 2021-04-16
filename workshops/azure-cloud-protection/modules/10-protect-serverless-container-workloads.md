---
Title: 2 - Connect to the ARO cluster
Description: Follow these instructions to connect to the ARO cluster that was created in the last lesson
Author: David Okeyode
---
# Lesson 2: Connect to the ARO cluster

In the previous lesson, an ARO cluster was created. If you have not completed this lesson, you can refer to it [here](1-create-aro-cluster.md).
In this workshop lesson, you will connect to the cluster as the kubeadmin user through the OpenShift web console and the OpenShift CLI. You'll be using this cluster for the rest of the lessons in this workshop. Here's what we'll be completing:

> * Connect to the ARO cluster using the OpenShift web console
> * Connect to the ARO cluster using the OpenShift CLI

## Connect to the cluster using the OpenShift web console
In this section, we will be completing the following tasks
* Obtain `kubeadmin` credentials for your ARO cluster
* Obtain the ARO cluster console URL
* Connect to the cluster web console using the `kubeadmin` credentials

1. Go to [Azure Cloud Shell](https://shell.azure.com) and sign in with your credentials

2. **Set the following variables in the shell environment in which you will execute the `az` commands.**
   ```
   LOCATION=uksouth       # the location of your cluster
   RESOURCEGROUP=aro-workshop-rg   # the resource group of your cluster that you created in the last lesson           
   CLUSTER=arocluster        # the name of your cluster
   ```
3. **Obtain the `kubeadmin` user password**
* We will store this value in a variable called **kubeadminpass**
```
kubeadminpass=$(az aro list-credentials \
  --name $CLUSTER \
  --resource-group $RESOURCEGROUP \
  --query kubeadminPassword -o tsv)
```
```
echo $kubeadminpass
```

4. **Obtain the cluster console URL**
* The URL will be in the following format: `https://console-openshift-console.apps.<random>.<region>.aroapp.io/`
* This domain name is publicly reachable because it is registered in BOTH the private DNS zone that was automatically created during the setup in the CoreDNS instance used by your ARO cluster.
* We will store this value in a variable called **consoleURL**

```
 consoleURL=$(az aro show \
    --name $CLUSTER \
    --resource-group $RESOURCEGROUP \
    --query "consoleProfile.url" -o tsv)
```
```
echo $consoleURL
```

5. **Launch the console URL in a browser and login using the `kubeadmin` credentials.**
![Azure Red Hat OpenShift login screen](../img/2-aro-console-login.png)

6. Keep the console open as you will be downloading the OpenShift command line tool in from here in an upcoming task

## Connect to the cluster using the OpenShift CLI
In this section, we will be completing the following tasks:
* Download and install the OpenShift CLI in Azure CloudShell
* Retrieve the ARO cluster API server's address
* Login to the ARO cluster API server using the kubeadmin credentials

1. **Download and install the latest OpenShift 4 CLI for Linux in Azure CloudShell using the following commands**
```
cd ~
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz

mkdir openshift
tar -zxvf openshift-client-linux.tar.gz -C openshift
echo 'export PATH=$PATH:~/openshift' >> ~/.bashrc && source ~/.bashrc
```
2. **OPTIONAL - If you are using a local shell session, use the following instructions to download and apply the command line tool. Skip this if you are using Azure CloudShell and go to step 3.**
*In the OpenShift Web Console, click on the **?** on the top right and then on **Command Line Tools**. Download the release appropriate to your machine.
![Screenshot that highlights the Command Line Tools option in the list when you select the ? icon.](../img/2-aro-download-cli.png)

3. **Retrieve the ARO cluster API server's address**
```
apiServer=$(az aro show -g $RESOURCEGROUP -n $CLUSTER --query apiserverProfile.url -o tsv)
```

4. **Login to the OpenShift cluster's API server using the kubeadmin credentials**
```
oc login $apiServer -u kubeadmin -p $kubeadminpass
```
You should receive a **Login successful** response after running the command

If you receive an error message, check that the variable values are correct using the `echo` command. You may need to run previous commands to set the values in your session.

![Screenshot that shows successful command line login](../img/2-aro-oc-login.png)


5. Verify connectivity using a few `oc` commands
```
oc get projects # show all projects that the current login has access to
```
* For a full reference of how to use the `oc` command line tool, refer to the documentations below:
   * [Administrator CLI commands](https://docs.openshift.com/container-platform/4.6/cli_reference/openshift_cli/administrator-cli-commands.html)
   * [Developer CLI commands](https://docs.openshift.com/container-platform/4.6/cli_reference/openshift_cli/developer-cli-commands.html)

## Next steps

In this lesson, you completed the following:
* Obtained the `kubeadmin` credentials for your cluster
* Obtained the cluster console URL
* Connected to the cluster web console using the `kubeadmin` credentials
* Downloaded and installed the OpenShift CLI in Azure CloudShell
* Retrieved the ARO cluster API server's address
* Connected to the ARO cluster API server using the kubeadmin credentials

In the next lesson, you will configure Azure AD authentication for your ARO cluster. Click here to proceed to the next lesson:
> [Configure Azure AD authentication for ARO](3-configure-aro-azuread.md)
