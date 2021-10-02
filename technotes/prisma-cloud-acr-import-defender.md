
---
Title: Import Prisma Cloud Defender into ACR
Author: David Okeyode
---

## Introduction

This tech note walks you through how to import the Prisma Cloud defender image from Palo Alto's cloud registry into an instance of Azure Container Registry (ACR)

### Pre-Requisites
> * Prisma Cloud License (access token included)
> * Azure Container Registry (ACR) instance. You can use the commands below to create a test instance:

```
RG=myResourceGroup
ACR=doacr$RANDOM
LOC=uksouth

az group create --name $RG --location $LOC
az acr create -n $ACR -g $RG --sku Standard

```

### Instructions
We have an option of two methods that we can use to import the Prisma Cloud defender image from the cloud registry into container registry: **`Basic auth`** OR **`URL auth`**. Please note the following before proceeding:

* Replace **`<access_token>`** in the commands below with the access token included in your license
* The length of time that images are available on the cloud registry complies with the product's standard n-2 support lifecycle. This means that you can only pull the latest image and the immediate previous two images from the cloud registry.

1. **Method 1: Basic auth**
* Import the image directly into ACR using the command below:

```
az acr import --name $ACR --source registry.twistlock.com/twistlock/defender:defender_21_08_514 --image defender:defender_21_08_514 --username prismacompute --password <access_token>

az acr import --name $ACR --source registry.twistlock.com/twistlock/defender:defender_21_08_514 --image defender:defender_21_08_514 --username prismacompute --password hodoavptoqgp3ghfz7istz7py6zyno4w


```

2. **Method 2: URL auth**
* Import the image directly into ACR using the command below:

```
az acr import -n $ACR --source registry-auth.twistlock.com/tw_<access_token>/twistlock/defender:defender_21_08_514
```

### REFERENCES
* [Prisma Cloud Container Images (SaaS)](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/install/twistlock_container_images.html)

* [Prisma Cloud Container Images (Compute)] - (https://docs.paloaltonetworks.com/prisma/prisma-cloud/21-08/prisma-cloud-compute-edition-admin/install/twistlock_container_images.html)

* [Prisma Cloud Support Lifecycle](https://docs.paloaltonetworks.com/prisma/prisma-cloud/21-08/prisma-cloud-compute-edition-admin/welcome/support_lifecycle.html)
