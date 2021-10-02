## Welcome

Welcome to the Bridgecrew - Azure Cloud workshop! Prisma™ Cloud is the most comprehensive cloud security solution availableon the market today with capabilities ranging from Cloud Security Posture Management (CSPM); Cloud Workload Protection (CWP);  Cloud Infrastructure Entitlement Management (CIEM) and Cloud Network Security (CNS). It provides comprehensive visibility and threat detection across your organization’s hybrid, multi-cloud environment (Azure, AWS, GCP, Alibaba, Oracle Cloud, Kubernetes). 

![readme-prisma](./images/readme-prisma.png)

This workshop was created as a walkthrough for an in person or virtual workshop, however you may feel free to run through at your own pace.

### Pre-requisites

* An Azure Subscription
  * This can be any Azure subscription where you have the owner role assignment. We will also be performing some actions in Azure AD and other services that may require the Application Administrator or Global Administrator level of access on the tenant level.

* A Prisma Cloud Enterprise Account
  * Prisma Cloud will be used to protect your Azure environment and services
* An Azure DevOps Organization
* A JIRA Account
* A GitHub Account

>* The [first module](modules/0-prerequisites.md) contains instructions on setting up the required accounts but you can also use existing accounts that you may have.
### Agenda

The workshop is designed to take approximately 5-6 hours to complete. It can be spread out over a 1 day or 2 days workshop.

|    | Module                   | Format       |
|----|--------------------------|--------------|
| 00 | [Setup Pre-Requisites](modules/0-prerequisites.md) | Hands on Lab |
| 01 | [Prepare Your Azure Environment](modules/1-prepare-the-environment.md) | Hands on Lab |
| 02 | [CLI Scan](modules/2-cli-scan.md) | Hands on Lab |
| 03 | [VS Code IDE Integration](modules/3-vscode-integration) | Hands on Lab |
| 04 | [Custom Policy](modules/4-custom-policy) | Hands on Lab |
| 05a | [GitHub Integration](modules/5a-github-integration.md) | Hands on Lab |
| 05b | [Azure Repos Integration](modules/5b-azure-repos-integration.md) | Hands on Lab |
| 06 | [Azure DevOps Pipeline](modules/6-azure-devops-integration.md) | Hands on Lab |
| 07 | [AKS Config Scan](modules/7-aks-config-scan.md) | Hands on Lab |
| 08 | Wrap / Clean Up     | Hands on Lab |
----

[Next](modules/0-prerequisites.md)