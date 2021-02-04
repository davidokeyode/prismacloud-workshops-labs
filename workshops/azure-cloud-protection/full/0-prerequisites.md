---
Title: 0 - Setup Pre-Requisites
Description: Follow these instructions to setup the pre-requisites needed to complete this workshop
Author: David Okeyode
---
# Module 0: Setup Pre-Requisites

In this workshop lesson, you will be setting up accounts that you need to follow the lessons in this workshop. Here are the exercises that we will complete in this lesson:

> * Create an Azure free trial subscription 
> * Create a Prisma Cloud Enterprise trial Account
> * Create a JIRA account
> * Create a Slack account

Feel free to skip any exercise where you already have an existing account that you can use.

## Exercise 1: Create an Azure free trial subscription
>* You need an "Outlook" account to complete this exercise. If you do not have one, you can go to [this link](https://outlook.live.com/owa/) and click on the **"Create free account"** option to create a free outlook account.
>* A credit card will be needed to validate your identity. This card will not be charged unless you upgrade. It will only be used to validate user identity.

1. Open a web browser tab and go to [https://bit.ly/azure-free-sub-trial](https://bit.ly/azure-free-sub-trial)
2. Click on **`Start for free`**
3. Sign in with your Outlook account.
4. In **`Your profile`** section, complete the following:
   * Country/Region: Select your country/region
   * First Name: Enter your first name
   * Last Name: Enter your last name
   * Email address: Your outlook email address
   * Phone: Your phone number without the country code
   * Company VatID: Leave empty
   * Click **`Next`**
5. In the **`Identity verification by phone`** section, verify that your phone number is correct and click **`Text me`**.
   >* A verification code will be sent in a text message to your phone. Enter the code and click **`Verify code`**
6. In the **`Identity verification by card`** section, complete the following:
   * Cardholder Name: Enter your name as it appears on your card
   * Card Number: Enter your card number
   * Expires: Select the expiry month and year
   * CVV: Enter the CVV information
   * Address Line 1: Enter the first line of your address
   * City: Enter your city
   * Postal Code: Enter your address post code
   * Click **`Next`**
7. In the **Agreement** section, select the option `I agree to the subscription agreement, offer fetails, and privacy statement` and click **`Sign up`**. 
   >* Wait for a few minutes for the subscription to be created.
8. You can go to [https://portal.azure.com](https://portal.azure.com) to verify your subscription once it has finished creating.


## Exercise 2: Create a Prisma Cloud Enterprise trial Account
>* You need a corporate email address to complete this exercise. It CANNOT be a public email like "outlook.com" or "yahoo.com". Public email domains are restricted from signing up.

1. Open a web browser tab and go to [https://marketplace.paloaltonetworks.com/s/](https://marketplace.paloaltonetworks.com/s/)
2. In the top right corner, click on "Create Account".
3. In the **`Sign In or Create Account`** window, enter your email address and select the **`I'm not a robot`** option to complete the captcha.
   >* Complete the captcha.
4. Complete the following information:
   * First Name: Enter your first name
   * Last Name: Enter your last name
   * Company Name: Enter your company's name
   * Street Address: Enter your company's street address
   * City: Enter your company's city
   * Country: Select your company's country
   * ZIP Code: Enter your post code
   * Select **`I accept the Privacy Agreement`**
   * Click **`Create Account`**   
5. Wait for the account to be created. You will receive an email in your corporate mailbox once the account is ready.


## Exercise 3: Create a JIRA account
1. Open a web browser tab and go to [https://www.atlassian.com/software/jira/free](https://www.atlassian.com/software/jira/free).
2. Under **`Jira Software`**, click on **`Choose one`**
![jira-selection](../images/0-jira-selection.png)

3. Click on **`Sign up with email`** and complete the following:
   * Work email: Enter your Outlook email address (the same one that you used to sign up for your Azure subscription).
   * Password: Enter your password
   * First Name: Enter your first name
   * Last Name: Enter your last name
   * Click **`Agree`**
   * Complete the captcha that you are presented
>* A verification email will be sent to your email address
![jira-signup](../images/0-jira-signup.png)

4. Go to your email inbox and click **`Yes, verify me`** to verify your email.
![jira-email-verify](../images/0-jira-email-verify.png)

5. In the **`Let's get started`** window, enter a name for your site and click **`Continue`**
>* This is like an organization name
![jira-email-verify](../images/0-jira-site-name.png)

6. You can skip the questions that you are presented and the option to invite team mates
7. Select **`Kanban*`** for the template
![jira-kanban](../images/0-jira-kanban.png)

8. In the **`Create Project`** window, complete the following:
   * Name: Azure-Cloud-Security
   * Key: ACS
   * Click **`Create`**
![jira-project](../images/0-jira-project.png)

9. You should now be able to access your JIRA console
![jira-project](../images/0-jira-kanban.png)


## Exercise 4: Create a Slack account
1. Open a web browser tab and go to [https://slack.com/get-started#/createnew](https://slack.com/get-started#/createnew).
2. Enter your Outlook email address and click **`Continue`**
   >* Ignore the message about using your work email
   >* A verification code will be sent to your email address
4. Go to your email inbox to obtain the verification code. Enter the verification code.
5. Click on **`Create a Workspace`**.
6. In the **`What's the name of your company or team?`** window, enter your company name and click **`Next`**.
7. In the **`What's your team working on right now?`** window, enter **`azure-security`** and click **`Next`**.
8. In the **`Who do you email most about azure-security?`**, click **`Skip this step`** and click **`Skip Step`**.
9. You should now be able to access your slack workspace and channel

## Next steps

In this lesson, you completed the following:
> * Created an Azure free trial subscription 
> * Created a Prisma Cloud Enterprise trial Account
> * Created a JIRA account
> * Created a Slack account

Proceed to the next lesson:
> [Onboard Azure Subscription to Prisma Cloud](1-onboard-azure-sub.md)
