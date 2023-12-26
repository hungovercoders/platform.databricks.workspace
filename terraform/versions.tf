terraform {


  backend "azurerm" {
    key = "platform.databricks.workspace.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.84.0"
    }
    databricks = {
      source = "databricks/databricks"
      //version = "<SPECIFY_VERSION>"
    }
  }
}

# provider "databricks" {
#   host = "https://adb-4255314659407434.14.azuredatabricks.net"
#   # azure_workspace_name  = "lrn-datagriff-dbwp-eun-dgrf"
#   # azure_resource_group  = "lrn-data-rg"
#   # azure_subscription_id = "829dab70-6cf8-487b-b8ca-ec74ab3ffbd8"

#   # azure_client_id       = "service-principal-client-id"
#   # azure_client_secret   = "service-principal-client-secret"
#   # azure_tenant_id       = "azure-tenant-id"
# }