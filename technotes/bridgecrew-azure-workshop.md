


### Pre-Req (Accounts)
* GitHub account
  * Fork the TerraGoat repository on GitHub
  * https://github.com/bridgecrewio/terragoat

* Bridgecrew cloud account
  * https://www.bridgecrew.cloud

* Terraform cloud account
  * https://app.terraform.io/


### Pre-Req (Dev PC)
* Git
* VS Code
  * Terraform extension
* Terraform
* Checkov

### Terraform setup
```
terraform login
```

### Azure setup
```
az login

subid=$(az account show --query id -o tsv)

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$subid"
```

### Bridgecrew setup
* https://www.bridgecrew.cloud/integrations → API tokens → Add token
  * Token name: workshop
  * 

```
YOUR_BC_API_KEY = "1ef96936-134b-4d1b-9de9-aef4c9ed94e5"
```

### Clone the forked TerraGoat repository
```
git clone https://github.com/davidokeyode/terragoat
cd terragoat
git status

```

### Run Checkov locally
* Scan results will show **`failed policies`**, **`reason for failure`** and **`steps to fix`**
* For dev and test, no need to upload results to bridgecrew cloud so we can remove the **`--bc-api-key`** parameter
* Send scan result of only your main branch (that you are deploying) to the bridgecrew platform
  * This way, you can review history of deployed resources in code 

* **Scan single template**
```
checkov -f terraform/azure/storage.tf --bc-api-key $YOUR_BC_API_KEY --repo-id davidokeyode/storage
```

* **Scan entire directory with -d**
```
checkov -d terraform/azure/ --bc-api-key $YOUR_BC_API_KEY --repo-id davidokeyode/azureterragoat
```

* **To get the list of policies that Checkov**
  * -l or --list
```
checkov --list
```

* **Select or skip checks**
  * -c or --check option to select a few tests
  * --skip-check to skip a few tests
```
checkov -f terraform/azure/storage.tf -c CKV_AZURE_93,CKV_AZURE_2

checkov -f terraform/azure/storage.tf --skip-check CKV_AZURE_93,CKV_AZURE_2
```

### Viewing results in Bridgecrew
* https://www.bridgecrew.cloud/projects


### Run Checkov in your IDE
* You can get feedback directly in your IDE using Bridgecrew’s Checkov Visual Studio Code extension. 
  * The tool highlights misconfigurations inline and in development environments—like spell check for IaC misconfigurations.

* First, you need to install and configure the extension
  * VS Code → Extensions → Checkov → Install
  * Checkov Extension Settings → Checkov: Token → paste the API Token from the Bridgecrew platform

* Scan the TerraGoat instance.tf file using the extension
  * Go to File → Add Folder to Workspace → terragoat/terraform/azure
  * Checkov will immediately start scanning and will highlight any identified misconfigurations, with red underline.
  * Open instance.tf → Move your cursor over the second code block resource azurerm_linux_virtual_machine "linux_machine". 
  * Select "View Problem"
  * Select "Quick Fix" for extension issue. This adds the following line to automatically fix the misconfiguration.
  ```
    allow_extension_operations = false
  ```


### CICD Integration overview
* Using Checkov CLI and VS Code extension relies on people following the processes.
* For consistency and validation guardrails, we need to continuously scan the code for misconfigurations before it makes its way into production. That's where automating IaC scanning in our CI/CD pipeline comes in. 
  * With Bridgecrew, we can scan templates before they are committed to our VCS when you run other unit and integration testing, or in your VCS. 
  * This allows you to provide automated feedback as a part of a CI run and, if in blocking mode, block misconfigured code.


### GitHub Actions Integration
* Bridgecrew cloud → Integrations → Add integration → GitHub Actions 
  * OR https://www.bridgecrew.cloud/integrations/githubActions
  * Token name: gh_action_token → Create

* Add GitHub Secrets at the repo level
  * GitHub Repo → Settings → Secrets → Actions → New repository secret (top right)
    * Name: BC_API_KEY
    * Value: c5a1b5f4-204e-40e5-aca5-28866ddde919
    * Add secret

* Add the step into your GitHub Action job configuration
  * GitHub Repo → Actions → "I understand my workflows, go ahead and enable them"
    * New Workflow → Set up a workflow yourself
    * Name: bridgecrew.yaml
    * Replace content with the following → Start commit → Commit new file
```
name: Bridgecrew
on:
  pull_request:
  push:
    branches:
      - master
jobs:
  scan:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8]
    steps:
    - uses: actions/checkout@v2
    - name: Run Bridgecrew 
      id: Bridgecrew
      uses: bridgecrewio/bridgecrew-action@master
      with:
        api-key: ${{ secrets.BC_API_KEY }}
        directory: terraform/azure
```

* Review action result

* Modify to "soft-fail"
  * This is good for observability
  * hard-fail for "guardrail"

```
name: Bridgecrew
on:
  pull_request:
  push:
    branches:
      - master
jobs:
  scan:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8]
    steps:
    - uses: actions/checkout@v2
    - name: Run Bridgecrew 
      id: Bridgecrew
      uses: bridgecrewio/bridgecrew-action@master
      with:
        api-key: ${{ secrets.BC_API_KEY }}
        directory: terraform/azure
        soft_fail: true
```


### Yor overview
* An open-source tool that automatically tags IaC templates with attribution and ownership details, unique IDs that get carried across to cloud resources, and any other need-to-know information.
  
* It can run locally, as a pre-commit hook, or in a CI/CD pipeline.

* For drift detection, the important tag is **`yor_trace`**. It's a unique identifier that helps us trace from a cloud runtime configuration back to the IaC that provisioned it. To do that we need 3 elements:
  * Yor automated tagging
  * Integration with the VCS that stores the IaC (we'll use GitHub as an example)
  * Cloud integration (we'll use Azure as an example)


* GitHub Repo → Code → Add file → Create new file
  * Path: .github/workflows/yor.yml
  * Add the following. This will run Yor to automatically tag your IaC resources every time you perform a push or pull request to your repo. 
```
name: IaC tag and trace

on:
  push:
  pull_request:

jobs:
  yor:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        name: Checkout repo
        with:
          fetch-depth: 0
      - name: Run yor action
        uses: bridgecrewio/yor-action@main
```





















































