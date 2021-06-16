---
Title: 9 - Protect Azure Kubernetes Service (AKS) Workloads
Description: Prisma Cloud Compute provides a comprehensive set of security capabilities to protect containerized workloads everywhere including AKS
Author: David Okeyode
---
## Module 9 Introduction: Protect Azure Kubernetes Service (AKS) Workloads

In this module, we will implement protection for AKS workloads. Here's what we'll be completing:

> * Assess Linux and Windows images in the registry for vulnerabilities, malware (static and dymanic) and compliance
> * Assess images in ACR instances with access limited with a firewall, service endpoint, or private endpoints such as Azure Private Link
> * Prevent vulnerable, compromised or non-compliant images from being committed by scanning in your pipelines
> * Prevent untrusted images from being deployed to AKS
> * [Prisma Cloud Windows Containers features](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/install/install_windows.html)

## Module 9 Exercises

In this module, we will begin to walk through some of the protection capabilities that Prisma Cloud supports for container registries in Azure. Here are the exercises that we will complete:

> * Deploy Sample App to AKS
> * Add Azure Credential in Prisma Cloud
> * Prevent untrusted images from being deployed to AKS
> * Configure protection for Windows pool in AKS
> * Configure and teat ACR webhook integration
> * Troubleshooting ACR Integration


## Exercise 1 - Deploy Sample App to AKS

1. Open the Cloud Shell

2. If you have more than one Azure subscription, ensure you are in the right one that you deployed the lab resources into
```
az account show
az account list -o table
az account set -s <subscription_name>
```

3. Configure kubectl to connect to your Kubernetes cluster, use the az aks get-credentials command. Kubectl is pre-installed in the Azure cloud shell. 
```
az aks get-credentials --resource-group azlab-rg --name azlab-aks
```

4. To verify the connection to your cluster, run the kubectl get nodes command to return a list of the cluster nodes.
```
kubectl get nodes
```

5. Create namespace
```
kubectl create namespace sock-shop
```

6. Clone the microservices-demo repository
```
git clone https://github.com/davidokeyode/microservices-demo.git
```

7. Go to the deploy/kubernetes folder
```
cd microservices-demo/deploy/kubernetes
```

8. Review file
```
code aks-complete-demo.yaml
```

9. Deploy app
```
kubectl apply -f aks-complete-demo.yaml
```

10. Get public IP of front-end
```
kubectl get services --selector=name=front-end -n sock-shop -o wide
kubectl get services -n sock-shop
```

11. Browse to it
```
http://<EXTERNAL-IP>
```

## Exercise 2 - Deploy the Prisma Cloud Compute Defender to AKS


## Exercise 3 - Implement Vulnerability Assessment

1. Configure a container image vulnerability assessment rule by going to the following location: 
* **`Compute`** → **`Defend`** → **`Vulnerabilities`** → **`Images`** → **`CI`** → **`Add Rule`**
	* **Rule Name**: Org Baseline Container Vulnerability Rule
	* **Alert Threshold**: Low
	* **Failure Threshold**: Medium
	* **Expand Advanced Settings**
		* **Apply rule only when vendor fixes are available**: On
	* Leave other settings at default value
	* Click on **`Save`**

2. Configure a host vulnerability assessment rule by going to the following location: 
* **`Compute`** → **`Defend`** → **`Vulnerabilities`** → **`Hosts`** → **`Running Hosts`** → **`Add Rule`**
	* **Rule Name**: Org Baseline Host Vulnerability Rule
	* **Alert Threshold**: Low
	* **Expand Advanced Settings**
		* **Apply rule only when vendor fixes are available**: On
	* Leave other settings at default value
	* Click on **`Save`**


## Exercise 5 - Configure Prisma Cloud Host and Container Compliance Rules
1. Configure a container image compliance assessment rule by going to the following location: 
* **`Compute`** → **`Defend`** → **`Compliance`** → **`Containers and Images`** → **`CI`** → **`Add Rule`**
	* **Rule Name**: Org Baseline Container Compliance Rule
	* **Compliance Template**: NIST SP 800-190
	* **Set the following policies to fail**
		* Sensitive information provided in environment variables
		* Private keys stored in image
		* Image contains malware
	* Leave other settings at default value
	* Click on **`Save`**

2. Configure a host compliance assessment rule by going to the following location: 
* **`Compute`** → **`Defend`** → **`Compliance`** → **`Hosts`** → **`Running Hosts`** → **`Add Rule`**
	* **Rule Name**: Org Baseline Host Compliance Rule
	* **Compliance Template**: GDPR
	* Leave other settings at default value
	* Click on **`Save`**


## Exercise 4 - Implement Compliance Assessment

## Exercise 5 - Implement Runtime Protection

## Exercise 6 - Implement OPA

## Next steps

In this lesson, you completed the following:
* 

In the next lesson, you will implement protection for Azure Serverless Service workloads (Functions, App Services, Container Instances). Click here to proceed to the next lesson:
> [Protect Windows Hosts and Containers in Azure](7-protect-windows-hosts-and-containers.md)
