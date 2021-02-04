---
Title: 3 - Configure JIRA integration in Prisma Cloud
Description: Follow these instructions to integrate your JIRA project with Prisma Cloud
Author: David Okeyode
---

# Module 3: Configure JIRA integration in Prisma Cloud

In the previous module, you added your Azure AD tenant to Prisma Cloud. In this module, you will integrate your JIRA project with Prisma Cloud. This allows Prisma Cloud to generate tickets in JIRA for security risks and incidents for protected subscriptions, services and workloads. Here are the exercises that we will be completing:

>* Prepare your JIRA account for integration into Prisma Cloud
>* Configure JIRA integration in your Prisma Cloud account
>* Create a JIRA notification template in your Prisma Cloud account
>* Create an alert rule in Prisma Cloud to raise tasks in JIRA

## Exercise 1 - Prepare JIRA for integration
>* In order to integrate Prisma Cloud with JIRA, we need to create a Prisma Cloud Application link in JIRA. This process requires an account that has administrative privileges in JIRA.

1. Open a web browser tab and go to the [JIRA Sign-In Page](https://id.atlassian.com/login) and sign in with your JIRA credentials.

2. In the top right corner, click on the **`Settings`** icon → **`Products`**

![jira-products](../images/3-jira-products.png)

3. In the **Configure Application Links** window, enter your Prisma Cloud console URL and click **`Create new link`**
>* You can get a full list of the console URLs [from this document](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/get-started-with-prisma-cloud/access-prisma-cloud.html)
>* Make sure you use your console URL for your Prisma cloud tenant.

![jira-app-link](../images/3-jira-app-link.png)

4. Disregard the message about **`No response was received`** and click **`Continue`**
![jira-app-link-message](../images/3-jira-app-link-message.png)

5. In the **Link applications** window, configure the following:
   * **Application Name**: Prisma-Cloud
   * **Application Type**: Generic Application
   * **Leave other settings as default**
   * **Create Incoming Link**: Selected
   * Make a note of the JIRA **Application URL** as you will need it later in this module
   * Click **`Continue`**

![jira-app-link-config](../images/3-jira-app-link-config.png)

6. Still in the **Link applications** window, configure the following:
   * **Consumer Key**: Specify a complex key (make a note of this as it will be needed later in this module)
   * **Consumer Name**: Prisma-To-Jira-Integration
   * **Public Key**: 
   ```
      MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnYoXB+BZ555jUIFyN+0b3g7haTchsyeWwDcUrTcebbDN1jy5zjZ/vp31//L9HzA0WCFtmgj5hhaFcMl1bCFY93oiobsiWsJmMLgDyYBghpManIQ73TEHDIAsV49r2TLtX01iRWSW65CefBHD6b/1rvrhxVDDKjfxgCMLojHBPb7nLqXMxOKrY8s1yCLXyzoFGTN6ankFgyJ0BQh+SMj/hyB59LPVin0bf415ME1FpCJ3yow258sOT7TAJ00ejyyhC3igh+nVQXP+1V0ztpnpfoXUypA7UKvdI0Qf1ZsviyHNwiNg7xgYc+H64cBmAgfcfDNzXyPmJZkM7cGC2y4ukQIDAQAB
   ```
   * Click **`Continue`**

![jira-app-link-config](../images/3-jira-app-link-config-b.png)



## Exercise 2 - Configure JIRA integration in Prisma Cloud
1. Open a web browser and go to your Prisma Cloud console 
2. Go to **`Settings`** → **`Integrations`** → **`Add New`**

![prisma-integrate-add](../images/3-prisma-integrate-add.png)

3. In the **Add Integration** window, configure the following:
   * **Integration Type**: JIRA
   * **Integration Name**: Prisma-To-Jira-Integration
   * **Description**: Prisma Cloud to JIRA Integration
   * **JIRA Login URL**: The JIRA Application URL that you made a note of earlier
   * **Consumer Key**: Enter the consumer key that you made a note of earlier
   * Click **`Generate Token`** 
   * You will see a **Token generated** message. Click **`Next`**

![jira-integrate-config](../images/3-jira-integrate-config.png)

4. Click the **`secret key URL link`** to retrieve the secret key.

![prisma-jira-secret-key](../images/3-prisma-jira-secret-key.png)

5. In the **Welcome to JIRA** window, click **`Allow`**.
>* This gives Prisma Cloud read and write permissions in your Jira account

![prisma-jira-allow](../images/3-prisma-jira-allow.png)

6. In the **Access Approved** page, copy the **`Verification Code`**.

![prisma-verification](../images/3-prisma-verification.png)

7. Back in the Prisma Cloud console, paste the varification code that you copied as the **`secret key`** → Click on **`Generate token`**

![prisma-jira-key](../images/3-prisma-jira-key.png)

8. You will see a **Token generated** message. Click **`Test`**. You should see a success message in the top right corner.

![prisma-jira-key](../images/3-prisma-jira-test.png)

9. Click on **`SAVE`**



## Exercise 3 - Create notification template in Prisma Cloud
1. In the Prisma Cloud console, go to **`Alerts`** → **`Notification Templates`** → **`Add New`**.

![jira-add-notification](../images/3-jira-add-notification.png)

2. In the **Choose Notification Template** window, select JIRA

![prisma-select-jira](../images/3-prisma-select-jira.png)

3. In the **Add JIRA Notification Template** window, configure the following:
   * **Template Name**: Jira-Azure-Alert-Template
   * **Integration**: Prisma-To-Jira-Integration
   * **Project**: Azure-Cloud-Security
   * **Issue Type**: Task
   * Click **`Next`**

![prisma-jira-template](../images/3-prisma-jira-template.png)

4. In the **Jira Fields** section, configure the following:
   * **Jira Fields**: Include **`Description`** in the selection. Mandatory fields are automatically selected based on the configuration in JIRA.
   * **Summary**: Construct the information that will be added to the summary
   ```
      <$CloudType> security/compliance violations detected  - <$PolicyName>
   ```
   * **Reporter**: Enter a JIRA user's name. The name will be auto-filled as you type it.
   * **Description**: Construct the information that will be added to the description
   ```
      Issue Description: <$PolicyDescription>
      Severity: <$RiskRating>
      Affected Resource: <$ResourceName>
      Resource Type: <$ResourceType>
      Resource Region: <$ResourceRegion>
      Cloud Account Name: <$AccountName>
      Alert URL: <$CallbackUrl>
      Detection Time: <$LastSeen>
      Resolution Steps: 
      <$PolicyRecommendation>
   ```
   * Click **`Next`**
![prisma-jira-alert-format](../images/3-prisma-jira-alert-format.png)

5. In the **Review** section, click **`Test`** then click **`Save`**

![prisma-jira-template-test](../images/3-prisma-jira-template-test.png)


## Exercise 4 - Create alert rule in Prisma Cloud
1. In the Prisma Cloud console, go to **`Alerts`** → **`Alert Rules`** → **`Add New`**.

![prisma-alertrule-add](../images/3-prisma-alertrule-add.png)

2. In the **Select Alert Rule Type** window, select **`Run`**

![prisma-alertrule-run](../images/3-prisma-alertrule-run.png)

3. In the **Add Alert Rule** window, configure the following:
   * **Alert Rule Name**: Azure-Security-Alert-Rule
   * **Description**: Alert Rule for Azure Subscriptions
   * Click **`Next`**

![](../images/3-prisma-rule-name.png)

4. In the **Target** section, configure the following:
   * **Account Groups**: Select the **`Default Account Group`** or another account group that includes your Azure subscription
   * Click **`Next`**

![](../images/3-prisma-jira-group.png)

5. In the **Select Policies** section, configure the following:
   * **Select all policies**: Selected 
   * Click **`Next`**

6. In the **Set Alert Notification** section, configure the following:
   * **JIRA**: Enabled
   * **Templates**: Jira-Azure-Alert-Template
   * **Trigger notification for config alert only after the alert is open for**: 0
   * Click **`Save`**

![](../images/3-prisma-jira-notification.png)


## Learn more
* [Integrate Prisma Cloud with Jira](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/configure-external-integrations-on-prisma-cloud/integrate-prisma-cloud-with-jira.html)
* [Create an Alert Rule for Run-Time Checks](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/manage-prisma-cloud-alerts/create-an-alert-rule.html)

## Next steps
In this module, you completed the following:
>* Prepared your JIRA account for integration into Prisma Cloud
>* Configured JIRA integration in your Prisma Cloud account
>* Created a JIRA notification template in your Prisma Cloud account
>* Created an alert rule in Prisma Cloud to raise tasks in JIRA

In the next module, you will deploy a vulnerable by design template in your Azure subscription. Click here to proceed to the next module:
> [Deploy vulnerable workload using terraform](4-deploy-vulnearble-workload.md)
