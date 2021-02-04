---
Title: 4 - Deploy a Ratings application in the ARO cluster
Description: Follow these instructions to You will be deploying a ratings application in the ARO cluster
Author: David Okeyode
---
# Lesson 4: Deploy a Ratings application in the ARO cluster
In this workshop lesson, you will be deploying a ratings application in your ARO cluster. 
![Application](../img/4-app-overview.png)
* **A MongoDB with pre-loaded data**
   * [Link to the pre-loaded data](https://github.com/microsoft/rating-api/raw/master/data.tar.gz)

* **A public facing API `rating-api`**
   * [Code GitHub repo](https://github.com/microsoft/rating-api)
   * A NodeJS application that connects to mongoDB container app to retrieve and rate items
   * The container exposes port 8080
   * MongoDB connection is configured using an environment variable called MONGODB_URI
   * We’ll build the container app using the [source-to-image (S2I) build strategy](https://aroworkshop.io/#source-to-image-s2i)
   
* **A public facing web frontend `rating-web`**
   * [Code GitHub repo](https://github.com/microsoft/rating-web)  
   * A NodeJS application that connects to the rating-api container app 
   * The web app connects to the API over the internal cluster DNS, using a proxy through an environment variable named API
   * The container exposes port 8080
   * rating-api connection is configured using an environment variable called `API` 
   * We'll build the container app using the [source-to-image (S2I) build strategy](https://aroworkshop.io/#source-to-image-s2i)

Once you're done, you'll have an experience similar to the below.

![Application](../img/4-app-overview-1.png)
![Application](../img/4-app-overview-2.png)
![Application](../img/4-app-overview-3.png)


Here's what we'll be completing in this lesson:

> * Creating a [project](https://docs.openshift.com/aro/4/applications/projects/working-with-projects.html) on the Azure Red Hat OpenShift Web Console
> * Deploying a MongoDB container that uses Azure Disks for [persistent storage](https://docs.openshift.com/aro/4/storage/understanding-persistent-storage.html)
> * Deploying a Node JS API and frontend app from Git Hub using [Source-To-Image (S2I)](https://docs.openshift.com/aro/4/openshift_images/create-images.html)
> * Exposing the web application frontend using [Routes](https://docs.openshift.com/aro/4/networking/routes/route-configuration.html)
> * Creating a [network policy](https://docs.openshift.com/aro/4/networking/network_policy/about-network-policy.html) to control communication between the different tiers in the application


## Exercise 1 - Create an OpenShift Project
1. **Create an OpenShift project**
>* A project allows a community of users to organize and manage their content in isolation from other communities.

* Create a new openshift project
```
    oc new-project workshop
``` 
* Set your current project to the newly created one
```
    oc project workshop
```

## Exercise 2 - Create the MongoDB container app
1. **Create mongoDB from template**
* ARO provides a container image and template to make creating a new MongoDB database service easy. We will use the `mongodb-persistent` template to define both a deployment configuration and a service.

* View available templates using the command below. The templates are preinstalled in the openshift namespace.
```
    oc get templates -n openshift
    oc get templates -n openshift | grep mongodb
```
* Create a mongoDB deployment using the `mongodb-persistent` template. You're passing in the values to be replaced (username, password and database) which generates a YAML/JSON file.
```
oc process openshift//mongodb-persistent \
    -p MONGODB_USER=ratingsuser \
    -p MONGODB_PASSWORD=ratingspassword \
    -p MONGODB_DATABASE=ratingsdb \
    -p MONGODB_ADMIN_PASSWORD=ratingspassword | oc create -f -
```
* Verify if the deployment of the mongoDB template was successful using the command line
>* The prior command created a secret, service, persistentvolumeclaim, and deploymentconfig
```
    oc get all
```    
* Retrieve the mongoDB service name (it will be needed later)
>* The api app will connect to the database using this name on port 27017. 
>* The service will be accessible at the following DNS name: [service name].[project name].svc.cluster.local E.g. mongodb.workshop.svc.cluster.local
>* This DNS name resolves only within the cluster
```
   oc get svc mongodb
```

* Verify the mongoDB deployment using the web console
>* You can obtain the console URL using `consoleURL=$(az aro show --name $CLUSTER --resource-group $RESOURCEGROUP --query "consoleProfile.url" -o tsv)`
** In the web console, switch to the "Developer" view
** Ensure that the "workshop" project is selected
** You should see a new deployment for mongoDB.

![Verify mongoDB deployment](../img/4-verify-mongodbapp.png)


## **Exercise 3 - Deploy Ratings API App**
1. **Fork the application to your own GitHub repository**
    - To be able to setup CI/CD webhooks, you’ll need to fork the application into your personal GitHub repository
    - Browse to this URL: https://github.com/microsoft/rating-api/fork then click on your GitHub account to select the destination
![Fork the ratings API repo](../img/4-github-fork.png)

2. **Use the OpenShift CLI to deploy the** `**rating-api**`
> **Note** You’re going to be using [source-to-image (S2I)](https://aroworkshop.io/#source-to-image-s2i) as a build strategy.
>* This will build a container image using the Docker file that is in the root of the repository and deploy the created image as a container

* Build and deploy the container image as a new app
```
    oc new-app https://github.com/<your GitHub username>/rating-api --strategy=source
``` 
* Verify deployment status
```
    oc status
```
![Verify the ratings api status](../img/4-verify-ratings-api-status.png)

3. **Configure the required environment variables**
>* The ***MONGODB_URI*** environment variable is required by the ***rating-api*** app to connect to the mongodb database on port 27017. We will supply the value to the rating-api deployment using `oc set env`.
>* There are three methods to do this

* METHOD 1 - Using the CLI
```
    oc set env deploy/rating-api MONGODB_URI=mongodb://ratingsuser:ratingspassword@mongodb:27017/ratingsdb
```
* METHOD 2 - Using the Web Console
    * Web console (Developer view) → Project → Overview → 1 Deployment → rating-api → Environment → Add "Single values (env)" 
        - **Name**: MONGODB_URI
        - **Value**: mongodb://ratingsuser:ratingspassword@mongodb:27017/ratingsdb

4. **Verify that the service is running**
>* We can verify that our `rating-api` application is able to connect to the mongodb database. We can verify this in the logs.
>* There are two methods to do this

* METHOD 1 - Using the CLI
    * Verify that you have the entry `"CONNECTED TO mongodb://ratingsuser:ratingspassword@mongodb:27017/ratingsdb"`
```
    oc get pods -n workshop # Obtain the running pods in the workshop project
    oc logs -f rating-api-xxxxxxxxxx-xxxx -n workshop # Obtain the logs for the rating-api pod. Replace xxxxxxxxxx-xxxx with the actual characters from the pod name
```
![Verify the ratings api pod name](../img/4-verify-ratings-api-pod.png)
![Verify the ratings api pod log](../img/4-verify-ratings-api-logs.png)

* METHOD 2 - Using the Web Console
    * OpenShift web console (Developer view) → Project Details → Overview → 1 Deployment → rating-api → Pods → Select rating-api Pod → Logs
    * Verify that you have the entry `"CONNECTED TO mongodb://ratingsuser:ratingspassword@mongodb:27017/ratingsdb"`

![Verify the ratings api pod log](../img/4-verify-ratings-api-logs-web.png)

5. **Retrieve** `**rating-api**` **service hostname**
* Retrieve the `rating-api` service name (it will be needed later)
>* The frontend web app will connect to the api app using this name on port 8080. 
>* The service will be accessible at the following DNS name: [service name].[project name].svc.cluster.local E.g. rating-api.workshop.svc.cluster.local
>* This DNS name resolves only within the cluster
```
   oc get svc rating-api
```

6. **Setup GitHub webhook**
>* To trigger S2I builds when we push code into the GitHib repo, we'll need to setup the GitHub webhook.
>* This will cause a new container image to be built and deployed when code changes are made in GitHub.

* Retrieve the GitHub webhook trigger secret. We'll need to use this secret in the GitHub webhook URL
```
   oc get bc/rating-api -o=jsonpath='{.spec.triggers..github.secret}'
```
* Make a note of the secret key in the red box. It will be needed later.
![Ratings api github secret](../img/4-ratings-api-github-webhook.png)

* Retrieve the GitHub webhook trigger URL from the build configuration
```
   oc describe bc/rating-api
```
* Make a note of the URL in the "Webhook GitHub URL" section
* Replace the `<secret>` placeholder with the secret you retrieved in the previous step to have a URL similar to https://api.z8deuehy.uksouth.aroapp.io:6443/apis/build.openshift.io/v1/namespaces/workshop/buildconfigs/rating-api/webhooks/SECRETSTRING/github. We will need this URL to setup the webhook on our GitHub repository
![Ratings api github webhook](../img/4-ratings-api-github-webhook-bc.png)

* In your GitHub repository and add a webhook
* Go to https://github.com/<your GitHub username>/rating-api → **Settings** → **Webhooks → Add Webhook**
    - **Payload URL**: The URL composition from above
    - **Content type**: application/json
    - Leave other settings as default
    - Click on **`Add webhook`**
![Ratings api github webhook configuration](../img/4-ratings-api-github-webhook-config.png)

* After adding the webhook, whenever we push a change to the GitHub repository, a new build will automatically start, and upon a successful build a new deployment will start.



## **Exercise 3 - Deploy Ratings frontend App**
1. **Fork the application to your own GitHub repository**
    - To be able to setup CI/CD webhooks, you will need to fork the application into your personal GitHub repository
    - Browse to this URL: https://github.com/microsoft/rating-web/fork then click on your GitHub account to select the destination
![Fork the ratings API repo](../img/5-github-fork.png)

2. **Use the OpenShift CLI to deploy the** `**rating-api**`
> **Note** We will use [source-to-image (S2I)](https://aroworkshop.io/#source-to-image-s2i) as a build strategy.
>* This will build a container image using the Docker file that is in the root of the repository and deploy the created image as a container

* Build and deploy the container image as a new app
```
    oc new-app https://github.com/<your GitHub username>/rating-web --strategy=source
``` 
* Verify deployment status
```
    oc status
```
![Verify the ratings api status](../img/5-verify-ratings-api-status.png)

3. **Configure the required environment variables**
>* The ***API*** environment variable is required by the ***rating-web*** app to connect to the ***rating-api*** service on port 8080. We will supply the value to the rating-web deployment using `oc set env`.
>* There are two methods to do this

* METHOD 1 - Using the CLI
```
    oc set env deploy rating-web API=http://rating-api:8080
```
![Configure the environment variable](../img/5-ratings-web-env-cli.png)

* METHOD 2 - Using the Web Console
    * Web console (Developer view) → Project → Select the `workshop` project if it is not selected → Overview → 2 Deployment → rating-web → Environment → Add "Single values (env)" 
        - **Name**: API
        - **Value**: http://rating-api:8080
![Configure the environment variable](../img/5-ratings-web-env-web.png)

4. **Expose the** `**rating-web**` **service using a Route**
* Expose the service. 
```
    oc get svc rating-web
    oc expose svc/rating-web
``` 
* Find out the created route hostname. The FQDN is a public DNS name.
```
    oc get route rating-web
```
![Expose the service](../img/5-ratings-web-expose-service.png)

5. **Test the service**
* Copy the route hostname and browse to it in a browser
* http://<route_hostname>

![Expose the service](../img/5-ratings-web-browser.png)


6. **Setup GitHub webhook**
>* To trigger S2I builds when we push code into the GitHib repo, we will need to setup the GitHub webhook.
>* This will cause a new container image to be built and deployed when code changes are made in GitHub.

* Retrieve the GitHub webhook trigger secret. We'll need to use this secret in the GitHub webhook URL
```
   oc get bc/rating-web -o=jsonpath='{.spec.triggers..github.secret}'
```
* Make a note of the secret key in the red box. It will be needed later.
![Ratings web github secret](../img/5-ratings-web-github-webhook.png)

* Retrieve the GitHub webhook trigger URL from the build configuration
```
   oc describe bc/rating-web
```
* Make a note of the URL in the "Webhook GitHub URL" section
* Replace the `<secret>` placeholder with the secret you retrieved in the previous step to have a URL similar to https://api.z8deuehy.uksouth.aroapp.io:6443/apis/build.openshift.io/v1/namespaces/workshop/buildconfigs/rating-web/webhooks/SECRETSTRING/github. We will need this URL to setup the webhook on our GitHub repository
![Ratings web github webhook](../img/5-ratings-web-github-webhook-bc.png)

* In your GitHub repository and add a webhook
* Go to https://github.com/<your GitHub username>/rating-web → **Settings** → **Webhooks → Add Webhook**
    - **Payload URL**: The URL composition from above
    - **Content type**: application/json
    - Leave other settings as default
    - Click on **`Add webhook`**
![Ratings api github webhook configuration](../img/5-ratings-web-github-webhook-config.png)

* After adding the webhook, whenever we push a change to the GitHub repository, a new build will automatically start, and upon a successful build a new deployment will start.

7. **Make a change to the website app and see the rolling update**
* Go to the https://github.com/<your GitHub username>/rating-web/blob/master/src/App.vue file in your GitHub repository on GitHub
* Edit the file, and change the `background-color: #999;` line to be `background-color: #0071c5`.
![Modify ratings web code](../img/5-ratings-web-code-modify.png)
* Commit the changes to the file into the `master` branch.
![Modify ratings web code](../img/5-ratings-web-code-commit.png)

* To **Verify build**
    - Go to the OpenShift Web Console (Developer view) → Builds → rating-web → Builds
    - You’ll see a new build queued up which was triggered by the push. 
    - Once this is done, it will trigger a new deployment and you should see the new website color updated.
![Verify build](../img/5-ratings-web-verify-build.png)

* To **Verify deployment**
    - Go to the OpenShift Web Console (Developer view) → Project → 2 Deployments → rating-web → Events
    ![Verify deployment](../img/5-ratings-web-verify-deployment.png)
    - Refresh frontend web site once completed
    ![Verify changed site](../img/5-ratings-web-verify-site.png)

## **Exercise 4 - Create Network Policy**
>* Now that we have the application working, it is time to apply some security hardening. >* We will use [network policies](https://docs.openshift.com/aro/4/networking/network_policy/about-network-policy.html) to restrict communication to the `rating-api`.

1. **Create network policy**
* Create a policy that applies to any pod matching the `app=rating-api` label.
  - The policy will allow ingress only from pods matching the `app=rating-web` label.
* Go to the OpenShift Web Console (Administrator view) → Networking → Network Policies → Make sure the `workshop` project is selected → Create Network Policy

![Create network policy](../img/5-create-network-policy.png)

* Copy and paste the following policy:
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-allow-from-web
  namespace: workshop
spec:
  podSelector:
    matchLabels:
      app: rating-api
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: rating-web
```
* Click "**Create**"
![Create network policy](../img/5-create-network-policy-2.png)

## Next steps

In this lesson, you completed the following:
> * Created an OpenShift project in ARO
> * Deployed a MongoDB container that uses Azure Disks for persistent storage using a template
> * Deployed a Node JS API and frontend app from Git Hub using Source-To-Image (S2I) deployment method
> * Exposed the web application frontend using OpenShift Routes
> * Created a network policy to control communication between the frontend web application and the api application


Proceed to the next lesson:
> [Explore ARO Internals](5-explore-aro-internals.md)
