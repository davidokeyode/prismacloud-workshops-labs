FROM    node:9-alpine
ADD     https://raw.githubusercontent.com/davidokeyode/prismacloud-workshops-labs/main/workshops/azure-cloud-protection/template/nodeapp/package.json /
ADD     https://raw.githubusercontent.com/davidokeyode/prismacloud-workshops-labs/main/workshops/azure-cloud-protection/template/nodeapp/server.js /
COPY 	sensitive.txt /tmp/sensitive.txt
ENV	CLIENT_ID="9aadafc1-bd59-4575-847a-21f0f0a517ea"
ENV	SECRET_KEY="~DUUvI~gbnZ_~~zrj3J4i83q69vuJGczn0"
RUN     npm install
EXPOSE  80
CMD     ["node", "server.js"]