## Welcome

Welcome to the Prisma Cloud Azure shift left workshop! Prisma™ Cloud is the most comprehensive cloud security solution availableon the market today with capabilities ranging from Cloud Security Posture Management (CSPM); Cloud Workload Protection (CWP);  Cloud Infrastructure Entitlement Management (CIEM) and Cloud Network Security (CNS). It provides comprehensive visibility and threat detection across your organization’s hybrid, multi-cloud environment (Azure, AWS, GCP, Alibaba, Oracle Cloud, Kubernetes). 

![readme-prisma](./images/readme-prisma.png)

This workshop was created as a walkthrough for Prisma Cloud shift-left capabilities for Azure.

### Pre-requisites

* An Azure Subscription
  * This can be any Azure subscription where you have the owner role assignment.
* A Prisma Cloud Compute Edition License
  * Prisma Cloud will be used to protect your Azure environment and services
* Bridgecrew License
* An Azure DevOps Organization
* A GitHub Account
* A JIRA Account

>* The [first module](modules/0-prerequisites.md) contains instructions on setting up the required accounts but you can also use existing accounts that you may have.
### Agenda

The workshop is designed to take approximately 5-6 hours to complete. It can be spread out over a 1 day or 2 days workshop.

|    | Module                   | Format       |
|----|--------------------------|--------------|
| 00 | [Setup Pre-Requisites](modules/0-prerequisites.md)                         | Hands on Lab |
| 01 | [Prepare Your Azure Environment](modules/1-prepare-the-environment.md) | Hands on Lab |
| 02 | [Deploy Prisma Cloud Compute Edition (PCCE) on AKS](modules/2-pcce-aks-deploy.md) | Hands on Lab |
| 03 | [Development Stage Shift Left](modules/3-pcce-development-stage-shift-left.md)                | Hands on Lab |
| 04 | [Configure Email integration in Prisma Cloud (CWPP)](modules/4-email-integration-cwpp.md) | Hands on Lab |
| 05 | Implement Shift Left Security for Azure    | Hands on Lab |
| 06 | Wrap / Clean Up     | Hands on Lab |
----

[Next](modules/0-prerequisites.md)