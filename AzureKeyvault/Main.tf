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

data "azurerm_key_vault" "AzureKeyvault" {
  name                = var.AzureKeyvault
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
  target_resource_id         = data.azurerm_key_vault.key_vault.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log.id

   log {
    category = "AuditEvent"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-Keyvaults-Availability" {
  name                = "Azure-Keyvaults-Availability"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-Keyvaults-Availability"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-Keyvaults-Availability{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "availability"
| where ResourceProvider contains "Microsoft.KeyVault/vaults"
| summarize by Average, bin(TimeGenerated, 1min), Resource
| render timechart
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 50
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-Keyvaults-APIresults" {
  name                = "Azure-Keyvaults-APIresults"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-Keyvaults-APIresults"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-Keyvaults-APIresults{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "serviceapiresult"
| where ResourceProvider contains "Microsoft.KeyVault/vaults"
| summarize by Average, bin(TimeGenerated, 1min), Resource
| render timechart
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 50
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-Keyvaults-APIlatency" {
  name                = "Azure-Keyvaults-APIlatency"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-Keyvaults-APIlatency"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-Keyvaults-APIlatency{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "serviceapilatency"
| where ResourceProvider contains "Microsoft.KeyVault/vaults"
| summarize by Average, bin(TimeGenerated, 1min), Resource
| render timechart
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 50
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-Keyvaults-APIhits" {
  name                = "Azure-Keyvaults-APIhits"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-Keyvaults-APIhits"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-Keyvaults-APIhits{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "serviceapihit"
| where ResourceProvider contains "Microsoft.KeyVault/vaults"
| summarize by Average, bin(TimeGenerated, 1min), Resource
| render timechart
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 50
  }
}

