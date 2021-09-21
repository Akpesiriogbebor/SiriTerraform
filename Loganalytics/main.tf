terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.77.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = ""
  features {}
}

data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  
}

data "azurerm_storage_account" "Storage" {
  name                = var.storage_account
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_log_analytics_workspace" "log" {
  name                = var.log_analytics_workspace
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_monitor_action_group" "action" {
  name                = "example-actiongroup"
  resource_group_name = var.resource_group_name
  short_name          = "exampleact"

  webhook_receiver {
    name        = "callmyapi"
    service_uri = "http://example.com/alert"
  }
}

  output "actiongroup-id" {
  value = azurerm_monitor_action_group.action.id
}


resource "azurerm_monitor_diagnostic_setting" "monitor" {
  name                       = var.monitor_diagnostic_setting
  target_resource_id         = data.azurerm_storage_account.Storage.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log.id

/*   log {
    category = "AuditEvent"
    enabled  = false

    retention_policy {
      enabled = false
    }
  } */

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "IngestionVolumeMB" {
  name                = "IngestionVolumeMB"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "The Summarize IngestionVolumeMB"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "The Summarize IngestionVolumeMB"
  enabled         = true
  query           = <<-QUERY
 Usage
  | project TimeGenerated, DataType, Solution, Quantity
  | where DataType in ('AzureMetrics')
  | summarize IngestionVolumeMB = sum(Quantity) > 0.7 by DataType
  | sort by IngestionVolumeMB
  | project DataType, IngestionVolumeMB 
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}