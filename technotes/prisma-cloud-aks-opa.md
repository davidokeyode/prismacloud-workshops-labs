

Defenders deployed to Kubernetes clusters can function as Open Policy Agent admission controllers.They can evaluate rules written in the Rego language to allow, alert, or block admission requests.

## STEP 1 - Create AKS Clouster
```
group=myPCResourceGroup
loc=eastus
aksname=myAKSCluster$RANDOM

az group create --name $group --location $loc

az aks create --resource-group $group --name $aksname --node-count 2 --generate-ssh-keys --node-vm-size Standard_D2a_v4 

az aks get-credentials --resource-group $group --name $aksname

kubectl get nodes

kubectl cluster-info
```

## STEP 2 - Install defender on AKS
* **`Manage`** → **`Defenders`** → **`Deploy`** → **`Defenders`**
	* **`Deployment method`**: Orchestrator
	* **`Choose the orchestrator type`**: Kubernetes
	* **`Nodes use Container Runtime Interface (CRI), not Docker`**: On
	* Download YAML file

* Upload YAML file to Cloudshell
```
kubectl create namespace twistlock
kubectl apply -f daemonset.yaml
```

## STEP 3 - Enable OPA on AKS

* **`Defend`** → **`Access`** → **`Admission`** → **`Go to settings`** → **`Admission control`**: Enabled → Copy the configuration

* **In Cloudshell**
```
code twistlock-admin-controller.yml

# Paste configuration copied earlier
# Set "apiVersion" to "admissionregistration.k8s.io/v1" instead of "admissionregistration.k8s.io/v1beta"
# Uncomment "webhooks.admissionReviewVersions" and set ["v1"]
# Uncomment "webhooks.sideEffects"

kubectl apply -f twistlock-admin-controller.yml
```

```
kubectl get pods -n twistlock
kubectl get events -n twistlock
kubectl logs 
```


```
kubectl get constraints
kubectl get constrainttemplates
kubectl get constrainttemplates <TEMPLATE> -o yaml
kubectl get constrainttemplates k8sazurecontainernoprivilege -o yaml
```

## STEP 4a - VERIFY BUILT-IN AUDIT RULE

* **`Defend`** → **`Access`** → **`Admission`** → **`Review rule`**
  * **Twistlock Labs - CIS - Privileged pod created**

* **Create privileged pod in AKS**

```
code priv-pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    securityContext:
      privileged: true

kubectl apply -f priv-pod.yaml
kubectl get pods
kubectl get events

kubectl delete -f priv-pod.yaml
```

* **Verify audit event was created**
  * **`Monitor`** → **`Events`** → **`Admission Audits`**


## STEP 4b - VERIFY CUSTOM RULE

* **Add custom rule in Prisma Cloud**
  * **`Defend`** → **`Access`** → **`Admission`** → **`+ Add rule`**
  * **`Rule Name`**: K8s cluster containers should not listen on restricted ports
  * **`Description`**: Block containers from listening on restricted ports to reduce the network attack surface
  * **`Effect`**: Block
  * **Rule**

```
match[{"msg": msg}] {
	input.request.operation == "CREATE"
	input.request.kind.kind == "Pod"
	input.request.resource.resource == "pods"
	input.request.object.spec.containers[_].ports[_].containerPort == 22
	msg := "It's not allowed to expose port 22 (SSH) with a Pod configuration!"
}
```

* **Verify block effect**

```
code restricted-container-port.yaml

apiVersion: v1
kind: Pod
metadata:
  name: ubuntu
  labels:
    app: ubuntu
spec:
  containers:
  - name: ubuntu
    image: docker.io/ubuntu:latest
    command: ["/bin/sleep", "3650d"]
    imagePullPolicy: IfNotPresent
    ports:
      - containerPort: 22
  restartPolicy: Always

kubectl apply -f restricted-container-port.yaml

kubectl delete -f restricted-container-port.yaml
```

* **Verify event was created**
  * **`Monitor`** → **`Events`** → **`Admission Audits`**


## REFERENCE
* [https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/access_control/open_policy_agent.html](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/access_control/open_policy_agent.html)