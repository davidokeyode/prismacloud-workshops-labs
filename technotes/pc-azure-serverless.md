




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
func init . --python
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

git add .
git commit -m "added api function"
git push
```

### Create pipeline
* Python Function App to Linux on Azure
* Select subscription
  * Function App name: function app
  * Working directory: $(System.DefaultWorkingDirectory)/
  * Validate and configure
  * Save and run

```

```

### Obtain function URL
```
FUNCTION_URL=$(az functionapp function show --resource-group $group --name $funcapp --function-name HttpFunc --query "invokeUrlTemplate" --output tsv)

FUNCTION_KEY=$(az functionapp function keys list --resource-group $group --name $funcapp --function-name HttpFunc --query "default" --output tsv)

curl $FUNCTION_URL?code=$FUNCTION_KEY&name=David
FUNCTION_CODE=$(echo "$FUNCTION_CODE" | tr -d '"') #Remove "" from result

```



### Download TwistCLI
* PC → Compute → Manage → System → Utilities 

```
curl --progress-bar -L -k --header "authorization: Bearer {TOKEN}" https://us-east1.cloud.twistlock.com/us-2-158291413/api/v1/util/twistcli > twistcli; chmod a+x twistcli;

./twistcli -h
```

### Azure DevOps Extension
* Install ADO extension
  * https://marketplace.visualstudio.com/items?itemName=Palo-Alto-Networks.build-release-task

* Add Prisma Cloud Service connection
  * Project setings → pipelines → Service connections → New service connection → Prisma cloud compute console
    * **Server URL**: PC → Compute → Manage → System → Utilities → Path to console
    * Username: PC → Settings → Access Control → Access Keys
    * Password: PC → Settings → Access Control → Access Keys
    * Service connection name: prisma-cloud-compute

* Add **`Prisma Cloud Compute Scan`** task before the **`publish artifact`** task in the **`build stage`**
  * **Scan type**: serverless
  * **Prisma Cloud Compute console**: prisma-cloud-compute
  * **Image or Function zip**: $(Build.ArtifactStagingDirectory)/$(Build.BuildId).zip
  * **Prisma Cloud Compute Project**: 

```
    - task: prisma-cloud-compute-scan@3
      inputs:
        scanType: 'serverless'
        twistlockService: 'prisma-cloud-compute'
        artifact: '$(Build.ArtifactStagingDirectory)/$(Build.BuildId).zip'  
```

### Review
* PC → Compute → Defend → Vulnerabilities → Functions → Functions → CI




## Serverless security (DEV STAGE)



### Serverless resource misconfiguration and compliance assessment
* App Service
* Function App
* Container Instance
* Logic App
* Container Apps

* Pipeline task using checkov docker image
```
    - script: docker run --tty --volume $(System.DefaultWorkingDirectory)/terraform:/tf bridgecrew/checkov --directory /tf --prisma-api-url https://api2.prismacloud.io --bc-api-key 7bf96634-1290-4939-809b-5f30c4a32182::P992audCaWXdebdnfWJAhQi6pJM= --repo-id David-MVP-Org1/$(System.TeamProject) --branch $(Build.SourceBranchName)
      displayName: Prisma Cloud - Scan Terraform
      enabled: 'false' 
```

* Pipeline steps using installed checkov
```
    - task: UsePythonVersion@0
      displayName: 'Use Python 3.7'
      inputs:
        versionSpec: 3.7 # Functions V2 supports Python 3.7 as of today
      enabled: 'true'

    - script: pip install checkov
      displayName: Install Checkov
      enabled: 'true'

    - script: checkov --directory $(System.DefaultWorkingDirectory)/terraform --prisma-api-url https://api2.prismacloud.io --bc-api-key 7bf96634-1290-4939-809b-5f30c4a32182::P992audCaWXdebdnfWJAhQi6pJM= --repo-id David-MVP-Org1/$(System.TeamProject) --branch $(Build.SourceBranchName)
      displayName: Prisma Cloud - Scan Terraform
      enabled: 'true'  
    
```


### Serverless vulnerability scan at DEV TIME
* **`PC`** → **`Compute`** → **`Monitor`** → **`Vulnerabilities`** → **`Functions`** → **`CI`** → **`Add rule`**
  * **Rule name**: org-serverless-vuln-policy
  * **Alert threshold**: Low
  * **Failure threshold**: Medium
  * **Apply rule only when vendor fixes are available**: ON
  * **Choose summary or detailed report**: Detailed
  * Save

* **`PC`** → **`Compute`** → **`Monitor`** → **`Compliance`** → **`Functions`** → **`CI`** → **`Add rule`**
  * **Rule name**: org-serverless-compliance-policy
  * **Alert threshold**: Low
  * **Failure threshold**: Medium
  * **Apply rule only when vendor fixes are available**: ON
  * **Choose summary or detailed report**: Detailed
  * Save

```
cd functionapp/

pip install --target="./.python_packages/lib/site-packages" -r ./requirements.txt

zip -r davidlocalfunc01.zip .python_packages .vscode HttpFunc host.json requirements.txt

../twistcli serverless -h

../twistcli serverless scan -h

PC_CONSOLE="https://us-east1.cloud.twistlock.com/us-2-158291413/"
PC_USER="7bf96634-1290-4939-809b-5f30c4a32182"
PC_PASS="P992audCaWXdebdnfWJAhQi6pJM="

../twistcli serverless scan --address $PC_CONSOLE -u $PC_USER -p $PC_PASS --details davidlocalfunc01.zip
```

### Serverless scan at DEV TIME
```


```

* Palo Alto Blog
  * https://www.paloaltonetworks.com/blog/category/announcement/

* Prisma Cloud Releases
  * https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-release-notes/prisma-cloud-release-information

* Prisma Cloud Compute Releases
  * https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-release-notes/prisma-cloud-compute-release-information


* Checkov CLI
  * https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html
  * https://www.checkov.io/2.Basics/Visualizing%20Checkov%20Output.html

* TwistCLI
  * 



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

* COmpute → Manage → Cloud Account → Add account → Azure → Add account (Agentless scan)

* Compute → Monitor → Compliance → Cloud discovery → Azure - Prisma Cloud Compute Role → Click Add


* Prisma Cloud Console → Compute → Defend → Vulnerabilities → Functions → Functions → Add rule

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