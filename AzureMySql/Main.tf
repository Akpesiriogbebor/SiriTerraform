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

data "azurerm_function_app" "functionapp" {
  name                = var.functionapp
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
  target_resource_id         = data.azurerm_function_app.functionapp.id
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


resource "azurerm_monitor_scheduled_query_rules_alert" "AzureMySQLPaaSStorage" {
  name                = "Azure-MySQLPaaS-Storage"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-Storage"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-Storage{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "storage_used"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-StoragePercent" {
  name                = "Azure-MySQLPaaS-StoragePercent"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-StoragePercent"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-StoragePercent{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "storage_percent"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-SecondsBehindMaster" {
  name                = "Azure-MySQLPaaS-SecondsBehindMaster"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-SecondsBehindMaster"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-SecondsBehindMaster{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "seconds_behind_master"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-MemoryPercent" {
  name                = "Azure-MySQLPaaS-MemoryPercent"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-MemoryPercent"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-MemoryPercent{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "memory_percent"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-LogStorage" {
  name                = "Azure-MySQLPaaS-LogStorage"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-LogStorage"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-LogStorage{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "serverlog_storage_usage"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-LogStoragePercent" {
  name                = "Azure-MySQLPaaS-LogStoragePercent"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-LogStoragePercent"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-LogStoragePercent{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "serverlog_storage_percent"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-CPUpercentage" {
  name                = "Azure-MySQLPaaS-CPUpercentage"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-CPUpercentage"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-CPUpercentage{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "cpu_percent"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-ConnectionsFailed" {
  name                = "Azure-MySQLPaaS-ConnectionsFailed"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-ConnectionsFailed"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-ConnectionsFailed{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "connections_failed"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-MySQLPaaS-ActiveConnections" {
  name                = "Azure-MySQLPaaS-ActiveConnections"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-MySQLPaaS-ActiveConnections"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-MySQLPaaS-ActiveConnections{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "active_connections"
| where ResourceProvider contains "Microsoft.DBforMySQL/servers"
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