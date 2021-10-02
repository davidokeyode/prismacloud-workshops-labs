---
Title: 2 -  - Deploy Prisma Cloud Compute Edition (PCCE) on AKS
Description: Follow these instructions to deploy Prisma Cloud Compute Edition (PCCE) on AKS
Author: David Okeyode
---


## 1. Supported Templates
a. Built-in policies
Bridgecrew -> Policies

* Azure Policy Index (about 140 built-in policies)
  * [https://docs.bridgecrew.io/docs/azure-policy-index](https://docs.bridgecrew.io/docs/azure-policy-index)

* AWS Policy Index (about 310 built-in policies)
  * [https://docs.bridgecrew.io/docs/aws-policy-index](https://docs.bridgecrew.io/docs/aws-policy-index)

* GCP Policy Index (about 79 built-in policies)
  * [https://docs.bridgecrew.io/docs/google-cloud-policy-index](https://docs.bridgecrew.io/docs/google-cloud-policy-index)

* Docker Policy Index (about 9 built-in policies)
  * [https://docs.bridgecrew.io/docs/docker-policy-index](https://docs.bridgecrew.io/docs/docker-policy-index)

* Kubernetes Policy Index (about 105 built-in policies)
  * [https://docs.bridgecrew.io/docs/kubernetes-policy-index](https://docs.bridgecrew.io/docs/kubernetes-policy-index)

* Git Policy Index (about 20 built-in policies)
  * [https://docs.bridgecrew.io/docs/git-policy-index](https://docs.bridgecrew.io/docs/git-policy-index)



## 2. Authoring or CI Phase - Using CLI Tool OR Docker Image

```
docker pull bridgecrew/checkov

git clone https://github.com/davidokeyode/prismacloud-shiftleft-exported
cd .\prismacloud-shiftleft-exported\

Mount host path (Docker -> Settings -> Resources -> File sharing -> Add-> C:/Users/azadmin/prismacloud-shiftleft-exported/Dockerfile

** checkov help
docker run --tty bridgecrew/checkov -h

** checkov dockerfile
docker run --tty --volume C:/Users/azadmin/prismacloud-shiftleft-exported/Dockerfile:/tf/Dockerfile bridgecrew/checkov --directory /tf --soft-fail

docker run --tty --volume C:/Users/azureadmin/prismacloud-shiftleft-exported/Dockerfile:/tf/Dockerfile bridgecrew/checkov --directory /tf --soft-fail

** checkov terraform
docker run --tty --volume C:/Users/azadmin/prismacloud-shiftleft-exported/terraform:/tf bridgecrew/checkov --directory /tf --soft-fail

docker run --tty --volume C:/Users/azureadmin/prismacloud-shiftleft-exported/terraform:/tf bridgecrew/checkov --directory /tf --soft-fail


** checkov armtemplate
docker run --tty --volume C:/Users/azadmin/prismacloud-shiftleft-exported/armtemplate:/tf bridgecrew/checkov --directory /tf --soft-fail

docker run --tty --volume C:/Users/azureadmin/prismacloud-shiftleft-exported/armtemplate:/tf bridgecrew/checkov --directory /tf --soft-fail

docker run --tty --volume C:/Users/azadmin/prismacloud-shiftleft-exported/terraform:/tf bridgecrew/checkov --file /tf/appconf.tf --bc-api-key 7d06ddb0-cf8c-4815-a109-5534c427a0b5
```

## Learn More

> * [Prisma Cloud twistCLI](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/tools/twistcli.html)


## Proceed to the next lesson:
> [Configure Custom Domain for Prisma Cloud Compute Edition (PCCE)](3-pcce-custom-domain.md) 
