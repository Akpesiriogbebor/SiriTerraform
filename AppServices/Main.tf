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

data "azurerm_app_service" "appservice" {
  name                = var.appservice
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
  target_resource_id         = data.azurerm_azurerm_app_service.appservice.id
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Average CPU Time" {
  name                = "Average CPU Time"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Average CPU Time"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure - App Services - Average CPU Time{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "cputime"
| where ResourceProvider contains "Microsoft.Web/sites"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "AverageResponseTime" {
  name                = "Average Response Time"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Average Response Time"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure - App Services - Average Response Time{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "AverageResponseTime"
| where ResourceProvider contains "Microsoft.Web/sites"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "AppServices-HTTP4XXerrors" {
  name                = "AppServices-HTTP4XXerrors"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "AppServices-HTTP4XXerrors"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure - AppServices-HTTP4XXerrors{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "HTTP4XX"
| where ResourceProvider contains "Microsoft.Web/sites"
| summarize by Average, bin(TimeGenerated, 1min), Resource
| render timechart
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 4
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "AppServices-HTTP5XXerrors" {
  name                = "AppServices-HTTP5XXerrors"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "AppServices-HTTP5XXerrors"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure - AppServices-HTTP5XXerrors{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "HTTP5XX"
| where ResourceProvider contains "Microsoft.Web/sites"
| summarize by Average, bin(TimeGenerated, 1min), Resource
| render timechart
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 4
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "AppServices-TotalRequests" {
  name                = "AppServices-TotalRequests"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "AppServices-TotalRequests"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure - AppServices-TotalRequests{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "Requests"
| where ResourceProvider contains "Microsoft.Web/sites"
| summarize by Average, bin(TimeGenerated, 1min), Resource
| render timechart
  QUERY
  severity        = 1
  frequency       = 5
  time_window     = 5
  
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 10
  }
}