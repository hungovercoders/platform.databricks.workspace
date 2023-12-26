variable "cluster_name" {
  description = "A name for the cluster."
  type        = string
  default     = "griff_cluster"
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

resource "databricks_cluster_policy" "team_policy" {
  name = "team_policy"

  definition = jsonencode({
    "instance_pool_id" : {
      "type" : "forbidden",
      "hidden" : false
    },
    "spark_version" : {
      "pattern" : ".+",
      "type" : "regex"
    },
    "node_type_id" : {
      "type" : "allowlist",
      "values" : [
        "Standard_F4s"
      ],
      "defaultValue" : "Standard_F4s"
    },
    "driver_node_type_id" : {
      "type" : "fixed",
      "value" : "Standard_F4s",
      "hidden" : false
    },
    "autoscale.min_workers" : {
      "type" : "fixed",
      "value" : 1,
      "hidden" : false
    },
    "autoscale.max_workers" : {
      "type" : "range",
      "maxValue" : 4,
      "defaultValue" : 1
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : false
    },
    "custom_tags.process" : {
      "pattern" : ".+",
      "type" : "regex"
    }
  })
}


resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  depends_on              = [databricks_cluster_policy.team_policy]
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = data.databricks_spark_version.latest_lts.id
  autotermination_minutes = var.cluster_autotermination_minutes
  autoscale {
    min_workers = var.cluster_num_workers
    max_workers = var.cluster_num_workers
  }
  is_pinned = false
  policy_id = databricks_cluster_policy.team_policy.id
  custom_tags = {
    "process" = "hungovercoders"
  }
}

# resource "databricks_cluster" "example_cluster" {
#   cluster_name            = var.cluster_name
#   node_type_id            = data.databricks_node_type.smallest.id
#   spark_version           = data.databricks_spark_version.latest_lts.id
#   autotermination_minutes = var.cluster_autotermination_minutes
#   num_workers             = var.cluster_num_workers
#   is_pinned               = false
# }


