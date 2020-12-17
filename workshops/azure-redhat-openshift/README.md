## Welcome

Welcome to the Prisma Cloud Azure RedHat OpenShift (ARO) workshop! ARO is a fully managed Red Hat OpenShift service in Azure that is jointly engineered and supported by Microsoft and Red Hat. In this workshop, you'll go through a set of tasks that will help you understand some of the concepts of deploying an ARO cluster in Azure, configuring Azure AD authentication for it, deploying and securing container based applications on top of ARO and securing it with the Prisma Cloud Compute solution.

This workshop was created as a walkthrough for an in person or virtual workshop, however you may feel free to run through at your own pace. The workshop updates and extends the instructions in the [original workshop here](https://aroworkshop.io/?WT.mc_id=AZ-MVP-5003870) to include the deployment of the ARO cluster and how to protect it with Prisma Cloud Compute solution.
### Some Pre-requisites

* An Azure Subscription
  * Ideally this is a PAYG subscription where you have owner role assignment. We'll be performing some actions on Azure AD and other services that may require Application Administrator or Global Administrator level of access also.
  * You can sign up for a new Azure accout [here](https://azure.microsoft.com/free/?WT.mc_id=AZ-MVP-5003870)
  * ARO requires a minimum of 40 cores to create and run an OpenShift cluster. The default Azure resource quota for a new Azure subscription does not meet this requirement. To request an increase in your resource limit, see [Standard quota: Increase limits by VM series](https://docs.microsoft.com/en-us/azure/azure-portal/supportability/per-vm-quota-requests?WT.mc_id=AZ-MVP-5003870)

* A Prisma Cloud Compute license
  * This can be either a Prisma Cloud Compute license only or a Prisma Cloud Enterprise license

* A GitHub Account
  * You'll need a personal GitHub account. You can sign up for free [here](https://github.com/join).

### Agenda

The workshop is designed to take approximately 5-6 hours to complete. It can be spread out over a 1 day or 2 days workshop.

|    | Module                   | Format       |
|----|--------------------------|--------------|
| 01 | [Create an Azure Red Hat OpenShift (ARO) cluster](full/1-create-aro-cluster.md)                         | Hands on Lab |
| 02 | [Connect to the ARO cluster](full/2-connect-aro-cluster.md) | Hands on Lab |
| 03 | [Configure Azure AD authentication for ARO](full/3-configure-aro-azuread.md)                | Hands on Lab |
| 04 | [Setup Go Microservices project](full/4-aro-go-microservices.md) | Hands on Lab |
| 05 | Explore ARO Internals              | Hands on Lab |
| 06 | Deploy the Prisma Cloud Compute console and defenders  | Hands on Lab |
| 07 | Explore Prisma Cloud Compute capabilities                  | Hands on Lab |
| 08 | Wrap / Clean Up     | Hands on Lab |
----

[Next](full/1-create-aro-cluster.md)
