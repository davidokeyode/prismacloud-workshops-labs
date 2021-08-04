##################################
# EDIT THE FOLLOWING PARAMETERS
#
# tenant_id :                   Active directory's ID
#                               (Portal) Azure AD -> Properties -> Directory ID
#
# subscription_id:              Subscription ID that you want to onboard
#                               Custom role are going to be created from this subscription
#                               Please use a permanent subscription
#
# cloud_environment:            Cloud environment to be used.
#                               Default: public
#                               Possible values are public, usgovernment, german, and china
#

variable "tenant_id" {
  type = string
  default = ""
}
variable "subscription_id" {
  type = string
  default = ""
}

variable "azuread_sp_enterprise_oid" {
  type = string
  default = ""
}
variable "cloud_environment" {
  type = string
  default = "public"
}


# The list of permissions added to the custom role
variable "custom_role_permissions" {
    type = list(string)
    default = [
      "Microsoft.Network/networkInterfaces/effectiveNetworkSecurityGroups/action",
      "Microsoft.Network/networkWatchers/securityGroupView/action",
      "Microsoft.Network/networkWatchers/queryFlowLogStatus/action",
      "Microsoft.Network/virtualwans/vpnconfiguration/action",
      "Microsoft.ContainerRegistry/registries/webhooks/getCallbackConfig/action",
      "Microsoft.Web/sites/config/list/action",
      "Microsoft.Web/sites/publishxml/action",
      "Microsoft.Storage/storageAccounts/*", # enable remediation for storage account
    ]
}


#############################
# Initializing the provider
##############################

terraform {
  required_providers {
    azuread = {
      version = "=1.4.0"
    }
    azurerm = {
      version = "=2.49.0"
    }
    random = {
      version = "=3.1.0"
    }
    time = {
      version = "=0.7.0"
    }
  }
}

provider "azuread" {
  tenant_id = var.tenant_id
  environment = var.cloud_environment
}
provider "azurerm" {
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
  features {}
}
provider "random" {}

provider "time" {}

#######################################################
# Setting up custom roles
#######################################################

resource "random_string" "unique_id" {
  length = 5
  min_lower = 5
  special = false
}

resource "azurerm_role_definition" "custom_prisma_role" {
  name        = "Prisma Cloud ${random_string.unique_id.result}"
  scope       = "/subscriptions/${var.subscription_id}"
  description = "Prisma Cloud custom role created via Terraform"
  assignable_scopes = ["/subscriptions/${var.subscription_id}"]
  permissions {
    actions     = var.custom_role_permissions
    not_actions = []
  }
  timeouts {
    create = "5m"
    read = "5m"
  }
}

resource "time_sleep" "wait_20_seconds" {
  depends_on = [
    azurerm_role_definition.custom_prisma_role
  ]
  create_duration = "20s"
}

resource "azurerm_role_assignment" "assign_custom_prisma_role" {
  scope       = "/subscriptions/${var.subscription_id}"
  principal_id = var.azuread_sp_enterprise_oid
  role_definition_id = azurerm_role_definition.custom_prisma_role.role_definition_resource_id
  depends_on = [
    time_sleep.wait_20_seconds
  ]
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "assign_reader" {
  scope       = "/subscriptions/${var.subscription_id}"
  principal_id = var.azuread_sp_enterprise_oid
  role_definition_name = "Reader"
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "assign_reader_data_access" {
  scope       = "/subscriptions/${var.subscription_id}"
  principal_id = var.azuread_sp_enterprise_oid
  role_definition_name = "Reader and Data Access"
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "assign_network_contrib" {
  scope       = "/subscriptions/${var.subscription_id}"
  principal_id = var.azuread_sp_enterprise_oid
  role_definition_name = "Network Contributor"
  skip_service_principal_aad_check = true
}