#!/bin/bash

PRISMA_CONSOLE=<Prisma_Cloud_Console_URL>
PRISMA_USER=<Prisma_Cloud_Username>
PRISMA_PASSWORD=<Prisma_Cloud_Password>
GITHUB_ACCOUNT=<GitHub_Account_Name>
GITHUB_REPO=<GitHub_Repo_Name>

scanresult=$(curl -k -u $PRISMA_USER:$PRISMA_PASSWORD -H 'Content-Type: application/json' "$PRISMA_CONSOLE/api/v1/coderepos?id=$GITHUB_ACCOUNT/$GITHUB_REPO" | jq '.[].pass')

scandetails=$(curl -k -u $PRISMA_USER:$PRISMA_PASSWORD -H 'Content-Type: application/json' "$PRISMA_CONSOLE/api/v1/coderepos?id=$GITHUB_ACCOUNT/$GITHUB_REPO" | jq '.[]')

if [ "$scanresult" == "true" ]; then
   echo "Code Repo scan passed!"
   exit 0
else
   echo "Code Repo scan failed!"
   echo $scandetails
   exit 1
fi