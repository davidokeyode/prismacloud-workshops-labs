---
Title: 5 - Remediate Security Risks and Compliance Violations with Prisma Cloud
Description: Follow these instructions to explore the Prisma Cloud console, remediate security risks and compliance violations using Prisma Cloud
Author: David Okeyode
---
# Module 5: Remediate Security Risks and Compliance Violations with Prisma Cloud

## Exercise 1 - Review the Prisma Cloud Dashboard
>* In order to simulate security and compliance violation detections by Prisma Cloud, we will deploy some sample templates that implements services that are badly configured into our Azure subscription. DO NOT deploy these templates into a production environment!

1. Open a web browser and go to your Prisma Cloud console 
2. In the left hand menu, click on **`Dashboard`**. Review the following sections: 
   * **Top Instances by Role**:  
   * **Alerts by Severity**: 
   * **Policy Violations by Type over Time**: 
   * **Top Policy Violations**: 
   * **Top Internet Connected Resources**:  
   * **Monitored Accounts**: 
   * **Monitored Resources**: 
   * **Open Alerts**:
   * **Connections from Internet**:
   * **Select Mode**: **`Monitor & Protect`**
>* The mode cannot be changed after an account has been onboarded. You will need to remove the account and re-onboard it to change the mode.
![prisma-monitor-protect](../images/1-prisma-monitor-protect.png)

3. In the left hand menu, click on **`Inventory`** → **`Assets`**. Review the following sections: 
   * **Unique Assets**:  
   * **Asset Trend**: 
   * **Assets By Classification**: 

4. In the left hand menu, click on **`Policies`**. In the filter pane, select only **`Azure`** for the **`CLOUD TYPE`** filter. Review the following columns of the built-in policies
   * **Policy Type**:
      * Config: Based on cloud resource misconfigurations. They could be aligned with security best practices or compliance frameworks. Examples are misconfigured cloud database or storage services.
      * Audit event: Based on suspicious user activities. 
      * Network: Based on suspicious network communications. For example, direct traffic from internet IPs or Suspicious IPs to known database server ports OR traffic patterns that matches crypto-mining or Cache DDoS attacks.
      * Anomaly: Based on external threat intelligence contextualizations and pre-built anomaly ML detections

   * **Severity**:
      * High
      * Medium
      * Low
   * **Category**:
      * Risk
      * Incident
   * **Class**: Behavioral, Misconfiguration, Privileged Activity Monitoring
   * **Status**: Enabled or Disabled
   * **Remediable**: Auto-remediation is available for alerts based on the policy

5. Investigate configuration, audit and network incidents
   * **Policy Type**:
      * Config
      * Network
      * Anomaly
      * Audit event 
   * **Severity**:
      * High
      * Medium
      * Low
   * **Category**:
      * Risk
      * Incident
   * **Class**: Behavioral, Misconfiguration, Privileged Activity Monitoring
   * **Status**: Enabled or Disabled
   * **Remediable**: Auto-remediation is available for alerts based on the policy

## Next steps

In this lesson, you completed the following:
* Deployed vulnerable services to Azure using terraform

In the next lesson, you will remediate security risks and and compliance violations with Prisma Cloud. Click here to proceed to the next lesson:
> [Remediate Security Risks and Compliance Violations with Prisma Cloud](5-respond-and-remediate.md)
