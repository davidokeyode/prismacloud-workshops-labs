## 5. Custom policies

* Policy-as-Code

- https://docs.bridgecrew.io/docs/v2-understanding-custom-policies
- We can create custom policies using either a Visual Editor or a Code Editor
- The Bridgecrew platform utilizes the Terraform attribute library and syntax
- See the Terraform Registry for lists of supported attributes and connection types per cloud provider - https://registry.terraform.io/namespaces/hashicorp

- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
- Before building a Custom Policy you should gather the following:

** Policy Name

** Guidelines - as with built-in Policies, the Guidelines are displayed with the details of each Error to explain the issue to the user and related personnel for investigation and prevention in the future.

** Benchmark (optional, only via Visual Policy Editor) - you can associate a Custom Policy with a benchmark and section. The Custom Policy will be checked in every scan but, when exporting Reports, will only appear in reports for the associated benchmark, in the section defined.

** Cloud Provider and Resource Type - each Custom Policy must be associated with a Provider and specific Resource Type.

** Details for Policy Definition - attributes, values, and resource connection types to be checked.


b. Custom policies sample
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration

Policy Name: Ensure App Configuration uses a SKU that supports private link
Guidelines: 

Ensure App Configuration uses a SKU that supports private link
Error: Ensure App Configuration uses a SKU that supports private link

Bridgecrew Policy ID: BC_AZR_CUSTOM_1
Checkov Check ID: CKV_AZURE_CUSTOM_1
Severity: MEDIUM

Ensure App Configuration uses a SKU that supports private link
Description
When using a supported SKU, Azure Private Link lets you connect your virtual network to Azure services without a public IP address at the source or destination. The private link platform handles the connectivity between the consumer and services over the Azure backbone network. By mapping private endpoints to your app configuration instances instead of the entire service, you'll also be protected against data leakage risks. Learn more at: https://aka.ms/appconfig/private-endpoint.

Fix - Runtime
Azure Portal
To change the policy using the Azure Portal, follow these steps:

Log in to the Azure Portal at https://portal.azure.com.

```
resource "azurerm_app_configuration" "example" {
    ...
+   sku       = standard
}
```


c. TEST

```
notepad prismacloud-shiftleft-exported\terraform\appconf.tf
```
```
resource "azurerm_app_configuration" "appconf" {
  name                = "appConf1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "free"
}
```

