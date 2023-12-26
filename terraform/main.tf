provider "azurerm" {
  features {

  }
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # tenant_id       = var.tenant_id
  # subscription_id = var.subscription_id
}

# resource "azurerm_databricks_workspace" "this" {
#   location            = "northeurope"
#   name                = "lrn-datagriff-dbwp-eun-dgrf"
#   resource_group_name = "lrn-data-rg"
#   sku                 = "premium"
# }

provider "databricks" {
  host                        = "https://adb-4255314659407434.14.azuredatabricks.net"
  azure_workspace_resource_id = "/subscriptions/829dab70-6cf8-487b-b8ca-ec74ab3ffbd8/resourceGroups/lrn-data-rg/providers/Microsoft.Databricks/workspaces/lrn-datagriff-dbwp-eun-dgrf"
  # azure_client_id             = var.client_id
  # azure_client_secret         = var.client_secret
  # azure_tenant_id             = var.tenant_id
}

variable "cluster_name" {
  description = "A name for the cluster."
  type        = string
  default     = "Griff Cluster"
}

variable "cluster_autotermination_minutes" {
  description = "How many minutes before automatically terminating due to inactivity."
  type        = number
  default     = 20
}

variable "cluster_num_workers" {
  description = "The number of workers."
  type        = number
  default     = 1
}

# Create the cluster with the "smallest" amount
# of resources allowed.
data "databricks_node_type" "smallest" {
  local_disk = true
}

# Use the latest Databricks Runtime
# Long Term Support (LTS) version.
data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = data.databricks_spark_version.latest_lts.id
  autotermination_minutes = var.cluster_autotermination_minutes
  num_workers             = var.cluster_num_workers
  is_pinned               = false
}