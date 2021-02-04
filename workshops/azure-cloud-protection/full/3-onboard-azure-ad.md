---
Title: 2 - Onboard Azure Active Directory (AAD) Tenant to Prisma Cloud
Description: Follow these instructions to onboard your Azure AD Tenant to Prisma Cloud
Author: David Okeyode
---

# Module 2: Onboard Azure Active Directory (AAD) Tenant to Prisma Cloud

In the previous module, you added your Azure subscription to Prisma Cloud. In this module, you will add your Azure Active Directory (AAD) tenant to Prisma Cloud. This allows Prisma Cloud to ingest AAD user information and configuration. This is the first step to protecting your cloud environment, services and workloads with Prisma Cloud. Here are the exercises that we will be completing:

> * Prepare your AAD tenant for onboarding
> * Add AAD tenant in Prisma Cloud
## Prepare your AAD tenant for onboarding
>* In order for Prisma Cloud to ingest user information and configuration from AAD, the application needs to be granted permissions to read the required user information. The following steps needs to be completed:
   * Register the Microsoft Insights resource provider
   * Enable Network Watcher in the Azure regions that you have resources
   * Create a storage account in each region where you have Azure resources
   * Enable flow logs for your network security groups (configure the logs to be stored in the storage accounts created earlier)

1. Open a web browser tab and go to the [Azure Portal](https://portal.azure.com) 

2. Go to **`Azure Active Directory`** → **`App Registrations`** → Click on **`All Applications`** → Click on the Prisma Cloud App that was created by the terraform template in the previous module. It has the naming format **`Prisma Cloud Onboarding xxxxxx`** 
![aad-app](../images/1-aad-app.png)

3. In the application window that opened, click on **`API Permissions`** → **`Add Permission`** → **`Microsoft Graph`**
![aad-permissions](../images/1-aad-permissions.png)

4. In the **Request API permissions** window, select **`Application Permissions`** → Search for **`User.Read.All`** → Expand **`User`** → Select **`User.Read.All`** → Click **`Add Permissions`**
![aad-add-permissions](../images/1-aad-add-permissions.png)

5. Back in the **API permissions** window, click on **`Grant admin consent for <AAD_TENANT>`** → In the window that pops up, click on **`Yes`**
![aad-grant-consent](../images/1-aad-grant-consent.png)

6. The permission should now display with the consent granted
![aad-consent-granted](../images/1-aad-consent-granted.png)
## Add AAD tenant in Prisma Cloud
1. Open a web browser and go to your Prisma Cloud console 
2. Go to **`Settings`** → **`Cloud Accounts`** → **`Add New`** → Select **`Azure`** 
   * **Cloud Account Name**: Enter the name of your Azure AD Tenant
   * **Onboard**: Azure Active Directory
   * **Azure Cloud Type**: Commercial
   * Click **`Next`**
![prisma-aad-add](../images/1-prisma-aad-add.png)

3. In the **Configure Account** window, configure the following:
   * **Directory (Tenant) ID**: Enter the tenant ID that you made a note of in the previous module
   * Click **`Next`**
![aad-tenant-id](../images/1-aad-tenant-id.png)

4. In the **Account Details** window, enter the following:
   * **Application (Client) ID**: Enter the output value of **`application_client_id`** from Exercise 4 - Step 7 of the previous module
   * **Application Client Secret**: Enter the output value of **`application_client_secret`** from Exercise 4 - Step 7 of the previous module
   * **Enterprise Application Object ID**: Enter the output value of **`enterprise_application_object_id`** from Exercise 4 - Step 7 of the previous module
![prisma-account-details-b](../images/1-prisma-account-details-b.png)

5. In the **Accounts Groups** window, select **`Default Account Group`** and click **`Next`**

10. In the **Status** window, verify the status and click **`Done`**
![prisma-aad-status](../images/1-prisma-aad-status.png)

11. Click **`Close`**

12. Your Azure Active Directory tenant should now be onboarded in Prisma Cloud.

## Learn more
* [Add an Azure Active Directory Tenant on Prisma Cloud](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/add-azure-active-directory-on-prisma-cloud.html)
## Next steps
In this module, you completed the following:
> * Prepare your AAD tenant for onboarding
> * Add AAD tenant in Prisma Cloud

In the next module, you will Configure JIRA integration in Prisma Cloud. Click here to proceed to the next lesson:
> [Configure JIRA integration in Prisma Cloud](3-jira-integration.md)
