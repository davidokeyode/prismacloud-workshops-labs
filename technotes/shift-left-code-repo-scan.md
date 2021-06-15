## Code Repository Scan

### 1. What is it?

### 2. What capabilities are available today?

### 3. How to implement?

******************************
*** GitHub Repository Scan ***
******************************
**a. Generate a GitHub access token**
* **`GitHub account`** → **`Settings`** → **`Developer Settings`** → **`Personal access tokens`** → **`Generate new token`**
	* **`Note`**: prisma-cloud-token
	* Set the scope to **`"repo"`** if you're scanning private repos
	* Set the scope to **`"public_repo"`** if you're scanning public repos
	* Generate new token

**b. Add the token to Prisma Cloud's credentials store**
* **`Prisma Cloud Console`** → **`Manage`** → **`Authentication`** → **`Credentials Store`** → **`Add Credential`**
	* **`Name`**: github-token
	* **`Description`**: GitHub Personal Access Token
	* **`Type`**: GitHub access token
	* **`API token`**: Paste the access token you generated in GitHub
	* Click **`Save`**

**c. Configure the repos to scan**
* **`Defend`** → **`Vulnerabilities`** → **`Code Repositories`** → **`Repositories`** → **`Add Scope/Add the first item`**
	* **`Provider`**: GitHub
	* **`Type`**: Private or Public
	* **`Credential`**: github-token
	* **`Repositories`**: prismacloud-shiftleft REPO
	* Click **`Add`** → **`Save`**

**d. Configure scan on code push**
* **In Prisma Cloud**
	* **`Defend`** → **`Vulnerabilities`** → **`Code Repositories`** → **`Repositories`** → **`Webhook settings`** → **`Copy the URL`**

* **In GitHub**
	* **`GitHub`** → **`Repo Settings`** → **`Webhooks`** → **`Add webhook`**
		* **`Payload URL`**: Paste the URL you copied from Prisma Cloud Console
		* **`Content type`**: application/json
		* Leave other settings at default
		* Click Add webhook

**e. Configure vulnerability scanning rule**
* **`Defend`** → **`Vulnerabilities`** → **`Code Repositories`** → **`Repositories`**
	* **`Rule Name`**: GitHub-Repo-Vulnerability-Scan
	* **`Scope`**: Different rules can be configured for different repositories


**f. Configure scanning frequency**
* **`Manage`** → **`System`** → **`Scan`** → **`Code repositories`**

**g. API Integration**
```
PC_CONSOLE=<Prisma_Cloud_Console_URL>
PC_USER=<Prisma_Cloud_Username>
PC_PASS=<Prisma_Cloud_User_Password>
GIT_ACCT=<Git_Account_Name>
GIT_REPO=<Git_Account_Repo>

scandetails=$(curl -k -u $PC_USER:$PC_PASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos?id=$GIT_ACCT/$GIT_REPO"|jq '.[-1]')

scanresult=$(curl -k -u $PC_USER:$PC_PASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos?id=$GIT_ACCT/$GIT_REPO"|jq '.[-1].pass')

if [ "$scanresult" == "true" ]; then
   echo "Code Repo scan passed!"
   exit 0
else
   echo "Code Repo scan failed!"
   echo $scandetails | jq
   exit 1
fi
```

******************************************
*** Local and Pipeline Repository Scan ***
******************************************

**a. Configure vulnerability scanning rule**
Defend → Vulnerabilities → Code Repositories → CI → Add rule

Rule Name: Code-Repo-Vulnerability-Scan
Scope: Different rules can be configured for different repositories E.g. "prod-pipeline/*" has a different rule than "devsystem/*"

Failure Threshold: Medium
Click Save


**b. Scan with twistCLI**

```
PC_CONSOLE=<Prisma_Cloud_Console_URL>
PC_USER=<Prisma_Cloud_Username>
PC_PASS=<Prisma_Cloud_User_Password>
GIT_ACCT=<Git_Account_Name>
GIT_REPO=<Git_Account_Repo>

git clone https://github.com/davidaz400c/prismacloud-shiftleft

./twistcli coderepo scan --address $PC_CONSOLE -u $PC_USER -p $PC_PASS --repository $GIT_ACCT/$GIT_REPO ./prismacloud-shiftleft
```

**c. API Integration**

```
scandetails=$(curl -k -u $PC_USER:$PC_PASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?name=$GIT_ACCT/$GIT_REPO"|jq '.[-1]')

scanresult=$(curl -k -u $PC_USER:$PC_PASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?name=$GIT_ACCT/$GIT_REPO"|jq '.[-1].pass')

if [ "$scanresult" == "true" ]; then
   echo "Code Repo scan passed!"
   exit 0
else
   echo "Code Repo scan failed!"
   echo $scandetails | jq
   exit 1
fi
```




run_checkov() {
  docker run --tty --volume /$(System.DefaultWorkingDirectory)/terraform:/tf  bridgecrew/checkov:latest --directory /tf
}

run_main() {
  run_checkov
  done
  wait
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  run_main
fi


run_checkov() {
  docker run --tty --volume $HOME/terraform/samples/integration-testing/src:/tf  bridgecrew/checkov:latest --directory /tf
}

run_main() {
  run_checkov
  done
  wait
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  run_main
fi