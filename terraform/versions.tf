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

provider "azurerm" {
  features {

  }
}

provider "databricks" {
  host                        = "https://adb-4255314659407434.14.azuredatabricks.net"
  azure_workspace_resource_id = "/subscriptions/829dab70-6cf8-487b-b8ca-ec74ab3ffbd8/resourceGroups/lrn-data-rg/providers/Microsoft.Databricks/workspaces/lrn-datagriff-dbwp-eun-dgrf"
  # azure_client_id             = var.client_id
  # azure_client_secret         = var.client_secret
  # azure_tenant_id             = var.tenant_id
}
