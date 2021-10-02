


What does Prisma Cloud use for ATP? - auto-focus????



1. **Deploy the Cortex XDR agent**
* **`Endpoint`** → **`Endpoint Management`** → **`Agent Installations`** → **`Create`**
	* **`Name`**: david-az-aks01
	* **`Package Type`**: Kubernetes Installer
	* **`Platform`**: Linux
	* **`Version`**: Select latest version

* **`Endpoint`** → **`Endpoint Management`** → **`Agent Installations`** → **`Right click agent installation`** → **`Download YAML installer`**

2. **Deploy the agent in AKS**

```
az aks get-credentials -g azlab-rg -n azlab-aks
kubectl create -f david-azure-aks01.yaml

kubectl get all -n cortex-xdr
kubectl get service, pod, deployment -n cortex-xdr

```

3. **Review the connected AKS nodes**
* **`Endpoint`** → **`Endpoint Management`** → **`Endpoint Administration`** 

4. **Assign protection policy to protected nodes**
* **`Endpoint`** → **`Policy Management`** → **`New Policy`** → **`Next`**
	* **Policy Name**: david-az-aks01
	* **Description**: Policy to protect AKS deployments
	* **Platform**: Linux
		* **Exploit**: Default
		* **Malware**: Default
		* **Restrictions**: Default
		* **Agent Settings**: Default
		* **Exceptions**: Default
	* Click **`Next`**

* Select the registered AKS nodes and click **`Next`**
* Review the **`Summary`** and click **`Done`**


5. **Customize protection profile**
* **`Endpoint`** → **`Policy Management`** → **`Prevention`** → **`Profiles`** → **`+ New Profile`**
	* **Select Platform**: **`Linux`** → **`Malware`** → **`Next`**
		* Profile Name: do-aks-malware-profile
		* Behavioural Threat Protection
			* Action Mode: Report

* **`Endpoint`** → **`Policy Management`** → **`Prevention`** → **`Profiles`** → **`+ New Profile`**
	* **Select Platform**: **`Linux`** → **`Exploit`** → **`Next`**
		* Profile Name: do-aks-exploit-profile
		* Exploit Protection for Additional Processes
			* Action Mode: Block
		* Create

*** Apply: Endpoint -> Policy management -> policy rules -> Right click -> edit




code shellinabox-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: shellinabox-deployment
spec:
  selector:
    matchLabels:
      app: shellinabox
  replicas: 1
  template:
    metadata:
      labels:
        app: shellinabox
    spec:
      containers:
      - name: shellinabox
        image: sspreitzer/shellinabox:latest
        ports:
        - containerPort: 4200


sspreitzer/shellinabox:latest

kubectl apply -f shellinabox-deployment.yaml

kubectl get deployment shellinabox-deployment

kubectl describe deployment shellinabox-deployment

kubectl get pod

kubectl exec --stdin --tty shellinabox-deployment-76787485b7-wqbv9 -- /bin/bash

Download malware

























ep - pm - new policy -> next
linux -> next -> done
profiles -> ne profile


policy rules -> 
5 profiles