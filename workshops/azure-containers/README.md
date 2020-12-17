## Welcome

Welcome to the Prisma Cloud Azure Containerization Security workshop! There are multiple options for running containers in Azure.

This workshop was created as a walkthrough for an in person or virtual workshop, however you may feel free to run through at your own pace. 
### Some Pre-requisites

* An Azure Subscription
  * This can be any Azure subscription type where you have owner role assignment. We'll be performing some actions on Azure AD and other services that may require Application Administrator or Global Administrator level of access also.
  * You can sign up for a new Azure accout [here](https://azure.microsoft.com/free/?WT.mc_id=AZ-MVP-5003870)

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
