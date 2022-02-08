

https://azuremarketplace.microsoft.com/en-us/marketplace/apps/paloaltonetworks.panorama?tab=Overview


Azure Portal -> Create a resource -> Palo Alto Networks Panorama
Subscription: Select your subscription
Resource group: dokeyode-RG
Virtual machine name: dokeyode-panorama
Region: UK South
Availability options: No infrastructure redundancy required
Security type: Standard
Image: Panorama (BYOL) - Gen1
Size: Standard D4 v2 (8 vcpus, 28 GiB memory)
Authentication type: Password
Username: azureadmin
Password: Enter a complex password

Virtual network: dokeyode-uksouth-vnet
Subnet: panorama-subnet (10.1.1.0/24)
Public IP: dokeyode-panorama-ip
NIC network security group: dokeyode-panorama-nsg