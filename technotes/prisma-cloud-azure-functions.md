


```
Create new project called functionapp

Generate git repo credential

git clone https://CharisCloud098@dev.azure.com/CharisCloud098/functionapp/_git/functionapp

cd functionapp
```

### Create storage account and container
```
random=$RANDOM
location=eastus
group=myResourceGroup
storage=storagetest$random

az group create --name $group --location $location

az storage account create --name $storage --resource-group $group --location $location --sku Standard_LRS

az storage container create --account-name $storage --name functionprojects --auth-mode key
```

### Create function app
```
funcapp=funcapp$random
funcversion=3
pythonversion=3.7

az functionapp create --name $funcapp --storage-account $storage --consumption-plan-location $location --resource-group $group --os-type Linux --runtime python --runtime-version $pythonversion --functions-version $funcversion
```

### Create python function project (CloudShell)
```
cd functionapp

func init PythonFunctionProj --python
cd PythonFunctionProj
ls
```

### Edit requirements file and add the following to **`azure-functions`** package
```
code requirements.txt

requests == 2.20.0
enum34 == 1.1.6
jsonpickle == 0.9.4
mock == 2.0.0
```

### Create HTTP trigerred function
```
func new --name HttpFunc --template "HTTP trigger" --authlevel "anonymous"
ls
```

### Edit function code
```
code HttpFunc/__init__.py

import requests
import enum34
import jsonpickle
import mock
```

### Push to git origin
```
git config --global user.name "David Okeyode"
git config --global user.email david@xxxxxxxxxxx.com

```

### Zip the function
```
zip -r PythonFunctionProj.zip .
```

### Upload packaged function to Azure Blob container and generate SAS
```
az storage blob upload --account-name $storage --container-name functionprojects --name "PythonFunctionProj.zip" --file "PythonFunctionProj.zip" --auth-mode key

enddate=`date -u -d "7 days" '+%Y-%m-%dT%H:%MZ'`

sas=$(az storage container generate-sas --account-name $storage --name functionprojects --permissions acdlrw --expiry $enddate --auth-mode key --https-only -o tsv)
```

### Deploy packaged function to function app
```
az webapp config appsettings set --name $funcapp --resource-group $group --settings WEBSITE_RUN_FROM_PACKAGE="https://$storage.blob.core.windows.net/functionprojects/PythonFunctionProj.zip?$sas"
```

###
1. https://github.com/davidokeyode/prismacloud-workshops-labs/blob/main/workshops/azure-cloud-protection-pcee/modules/2-onboard-azure-sub.md

2. https://github.com/davidokeyode/prismacloud-workshops-labs/blob/main/workshops/azure-cloud-protection-pcee/modules/6-implement-cloud-discovery.md




- https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/compliance/cloud_discovery_saas
Ingestion Based Discovery
After onboarding a cloud account into the platform, you can reuse the same onboarded account in Compute for Cloud Discovery without the need for additional permissions on cloud accounts. Cloud Discovery uses this ingested data to discover unprotected workloads across your monitored environment. By using the same ingested metadata from cloud providers for both CSPM and CWP, the time to scan for unprotected resources is reduced substantially, providing instant visibility into undefended workloads in your organization.
Prisma Cloud needs an additional set of permissions to enable protection for these workloads. For example, to deploy Defenders automatically on undefended VM machines. Full feature-wise permissions listing is available in this doc along with protection mode for the onboarding template.




### Scanning a serverless function
* Configure Prisma Cloud to periodically scan your serverless functions. 
* Unlike image scanning, all function scanning is handled by Console.

* COmpute -> Manage -> Cloud Account -> Add account -> Azure -> Add account (Agentless scan)

* Compute → Monitor → Compliance → Cloud discovery → Azure - Prisma Cloud Compute Role → Click Add


* Prisma Cloud Console -> Compute -> Defend -> Vulnerabilities -> Functions -> Functions -> Add rule

. In the dialog, enter the following settings:
(AWS only) Select Scan only latest versions to only scan the latest version of each function. Otherwise, the scanning will cover all versions of each function up to the specified Limit value.
(AWS only) Select Scan Lambda Layers to enable scanning function layers as well.
(AWS only) Specify which regions to scan in AWS Scanning scope. By default, the scope is applied to Regular regions. Other options include China regions or Goverment regins.
Specify a Limit for the number of functions to scan.
Prisma Cloud scans the X most recent functions, where X is the limit value. Set this value to '0' to scan all functions.
For scanning Google Cloud Functions with GCP organization level credentials, the limit value is for the entire organization. Increase the limit as needed to cover all the projects within your GCP organization.
Select the accounts to scan by credential. If you wish to add an account, click on Add credential.
Click Add.
Click the green save button.
View the scan report.
Go to Monitor > Vulnerabilities > Functions > Scanned functions.
All vulnerabilities identified in the latest serverless scan report can be exported to a CSV file by clicking on the CSV button in the top right of the table.