


### Create azure credentials for deployment
```
az ad sp create-for-rbac -n "PaloFwApp" --role Contributor
```

{
  "appId": "f0fb48b6-9352-45f9-8858-3160ee76277a",
  "displayName": "PaloFwApp",
  "name": "f0fb48b6-9352-45f9-8858-3160ee76277a",
  "password": "9_zTSCsg8KoGoQ1c6el0H1iKKxynAmUFgf",
  "tenant": "f5e96db6-6cf6-49f0-a093-b47425c2d402"
}


Azure Portal

Create a resource -> VM-Series Next-Generation Firewall from Palo Alto Networks -> 
VM-Series Next Generation Firewall (BYOL and ELA) -> Create

* Subscription
* Resource Group
* Region: UK South
* Username: paloadmin
* Authentication type: Password
* Password: 
* Confirm password: 

In the Networking tab, configure the following:
* Virtual network: Create New
    * Name: fwVNET
    * Address range: 10.10.0.0/16
    * Sec-Mgmt-Subnet - 10.10.10.0/24
    * External-Subnet - 10.10.12.0/24
    * Internal-Subnet - 10.10.11.0/24
    * OK
* Network Security Group - inbound source IP: Your IP

In the VM-Series Configuration tab, configure the following:
* Public IP address: fwMgmtPublicIP
* DNS Name: davidpalofw
* VM name of VM-Series: paloaltofw
* VM-Series Version: latest
* Enable Bootstrap: No
* Virtual machine size: Standard D3 v2
* Next: Review + create >


### Activate license
* https://support.paloaltonetworks.com/ -> Sign in -> david@cloudsecnews.com
* Assets -> Software NGFW Credits -> Create Deployment Profile
    * Select firewall type: VM-Series
    * Select a vCPU configuration type: Fixed vCPU models
    * Next
    * Profile Name: Azure-Firewall-paloaltofw
    * Number of Firewalls: 1
    * Fixed vCPU model: VM-300 (4 vCPUs)
    * Security Use Case: Custom
    * Customize Subscriptions: Threat Prevention; Advanced URL Filtering; DNS; Global Protect; DLP; Wildfire; SD-WAN; URL Filtering
    * Use Credits to Enable VM Panorama: For Management; As Dedicated Log Collector
    * Create Deployment Profile
* Click on deployment profile and make a note of the Auth Code



### Post Deployment
* Browse to https://davidpalofw.uksouth.cloudapp.azure.com
    * Username: paloadmin
    * Password: 

* Device -> Licenses -> Activate feature using authorization code -> Paste Authorization Code from earlier -> OK -> OK (to agree to services restart)
 
 
### Configure public IP and NSG for external NIC
* paloaltofw01-davidpalofw-eth1
    * fwExternalPublicIP
    * Basic
    * Static

* Create Network Security Group
    * Resource Group: paloalto-RG
    * Name: fwExternal-NSG

* Add inbound rule
    * Source: IP Addresses
    * Source IP addresses/CIDR ranges: Your IP
    * Destination port ranges: *
    * Name: allow-all-from-trusted
    * Add

* Associate NSG with External NIC of firewall


Network -> Interfaces -> 
Interface Name: ethernet1/2
Interface Type: Layer3
Type: DHCP Client 
* Commit all changes
