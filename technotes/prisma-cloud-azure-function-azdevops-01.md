

https://github.com/microsoft/devops-project-samples/tree/master/node/plain/functionApp


* Create project in Azure DevOps
* Create repo called functionapp
  * Generate git credential and make note of password

* Import code from GitHUb into Azure Repos
```
git clone https://github.com/microsoft/devops-project-samples.git

git clone <repo_url>

git clone https://CharisCloud003@dev.azure.com/CharisCloud003/PrismaCloud/_git/functionApp

cp -a /devops-project-samples/tree/master/node/plain/functionApp/* /functionApp/
```


  * https://github.com/microsoft/devops-project-samples/tree/master/node/plain/functionApp



### Create project from Azure DevOps demo generator
* PartsUnlimited


### Create storage account and container
```
random=$RANDOM
location=eastus
group=myResourceGroup
plan=$location-win-plan

az group create --name $group --location $location
```

### Create app service plan nd web apps
```
az appservice plan create -g $group -n $plan --sku S1

az webapp create -g MyResourceGroup -p $plan -n PartsUnlimited-Web-$random
az webapp create -g MyResourceGroup -p $plan -n PartsUnlimited-API-$random
```



































































