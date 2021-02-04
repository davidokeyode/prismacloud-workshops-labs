---
Title: 1 - Prepare the Environment
Description: Follow these instructions to deploy Azure resources that we will use for the exercises in this workshop
Author: David Okeyode
---
# Lesson 1: Provision Azure Resources

In this workshop lesson, you'll provision resources in your Azure subscription using an ARM template.
The following list of resources will be deployed during the provisioning process (including dependencies like disks, network interfaces, public IP addresses, etc.):

Name | Resource Type | Purpose
-----| ------------- | -------
azlab-vnet | Virtual network | Vvirtual network that hosts both Azure VMs
azlab-win | Virtual machine | Windows Server to test the host protection capabilities of Prisma Cloud
azlab-linux | Virtual machine | Linux Server to test the host protection capabilities of Prisma Cloud
azlab-nsg | Network security group | NSG for the 2-VMs
azlabcr[uniqestring] | Container registry | Container registry to store application images
azlab-aks | Kubernetes service | Kubernetes service to test container security capabilities of Prisma Cloud
azlab-fa-[uniqestring] | Function App | Demonstrating related built-in and custom security recommendations
azlab-splan | App Service plan | App Service plan to host the containerized web app
azlab-app-[uniqestring] | App Service | App service to be for hosting a containerized web app
azlabsa[uniqestring] | Storage account | Demonstrating related security recommendations
azlab-sql-[uniqestring] | SQL server | To be using for the sample database
azlab-as | SQL database | Sample database based on AdventureWorks template
azlab-kv-[uniqestring] | Key vault | Demonstrating Key Vault related recommendations and security alerts
SecurityCenterFree | Solution | Default workspace solution used for Security Center free tier
azlab-la-[uniqestring]	| Log Analytics workspace | Log Analytics workspace used for data collection and analysis, storing logs and continuous export data

<img src="../img/1-lab-environment.png"?raw=true">

### Deploy Workshop Resources Using an ARM Template
1. Prepare your lab environment by clicking on the blue **Deploy to Azure** button below:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdavidokeyode%2Fprismacloud-workshops-labs%2Fmain%2Fworkshops%2Fazure-cloud-workload-protection%2Ftemplate%2Fazlabtemplatedeploy.json" target="_blank"><img src="https://aka.ms/deploytoazurebutton"/></a>

2.	You will be redirected to Azure Portal → custom deployment page where you should specify mandatory fields for deployment.
3.	On the subscription field, select your **Azure subscription**.
4.	On the resource group field, click on **Create new** and name it as **azlab** (you can pick any name you want or keep the default).
5.	On the parameters section, select the closest data center **region** to your current location (all downstream resources will be created in the same region as the resource group).
6. Select a password that will be used across services (such as credentials for virtual machines and SQL database)
> Notice that password must be between 12 and 72 characters and have 3 of the following: 1 lower case, 1 upper case, 1 number and 1 special character.
7.	Click **Review + create** to start the validation process. Once validation passed, click on **Create** to start the ARM deployment on your subscription.
8.	The deployment takes about **10 minutes** to complete.<br>

> The *deployment is in progress* page continues to update and show the resources being uploaded to the environment assuming the deployment is successful.  
> During the deployment, additional resource group will be created automatically for Kubernetes resources named as "asclab-aks".<br>

## Next steps

In this lesson, you provisioned resources in your Azure subscription using an ARM template.

Proceed to the next lesson:
> [Connect to the ARO cluster](2-connect-aro-cluster.md)
