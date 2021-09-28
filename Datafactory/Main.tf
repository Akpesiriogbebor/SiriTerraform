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

data "azurerm_data_factory" "datafactory" {
  name                = var.datafactory
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
  target_resource_id         = data.azurerm_data_factory.datafactory.id
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

resource "azurerm_monitor_scheduled_query_rules_alert" "DataFactoryAverageTaskPickupDelay" {
  name                = "DataFactory-AverageTaskPickupDelay"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "DataFactory-AverageTaskPickupDelay"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure - DataFactory-AverageTaskPickupDelay{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "integrationruntimeaveragetaskpickupdelay"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "DataFactoryPipelineFailedRuns" {
  name                = "DataFactory-PipelineFailedRuns"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "DataFactory-PipelineFailedRuns"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-DataFactory-PipelineFailedRuns{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "integrationruntimeaveragetaskpickupdelay"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-DataFactory-FailedRuns" {
  name                = "Azure-DataFactory-FailedRuns"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-DataFactory-FailedRuns"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-Azure-DataFactory-FailedRuns{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "activityfailedruns"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-DataFactory-PipelineFailedRuns" {
  name                = "Azure-DataFactory-PipelineFailedRuns"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-DataFactory-PipelineFailedRuns"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-DataFactory-PipelineFailedRuns{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "pipelinefailedruns"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-DataFactory-RuntimeAvailableNodes" {
  name                = "Azure-DataFactory-RuntimeAvailableNodes"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-DataFactory-RuntimeAvailableNodes"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-DataFactory-RuntimeAvailableNodes{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "IntegrationRuntimeAvailableNodeNumber"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-DataFactoryIntegrationRuntimeCpuPercentage" {
  name                = "Azure-DataFactoryIntegrationRuntimeCpuPercentage"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-DataFactoryIntegrationRuntimeCpuPercentage"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-DataFactoryIntegrationRuntimeCpuPercentages{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "IntegrationRuntimeCpuPercentage"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-DataFactoryIntegrationRuntimeQueueLength" {
  name                = "Azure-DataFactoryIntegrationRuntimeQueueLength"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-DataFactoryIntegrationRuntimeQueueLength"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-DataFactoryIntegrationRuntimeQueueLength{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "IntegrationRuntimeQueueLength"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-DataFactory-FactorySizeInGbUnits" {
  name                = "Azure-DataFactory-FactorySizeInGbUnits"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-DataFactory-FactorySizeInGbUnits"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-DataFactory-FactorySizeInGbUnits{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "FactorySizeInGbUnits"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "Azure-DataFactoryActivitySucceededRuns" {
  name                = "Azure-DataFactoryActivitySucceededRuns"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  action {
    action_group           = [azurerm_monitor_action_group.action.id]
    email_subject          = "Azure-DataFactoryActivitySucceededRuns"
  }

  data_source_id  = data.azurerm_log_analytics_workspace.log.id
  description     = "Azure-DataFactoryActivitySucceededRuns{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
  enabled         = true
  query           = <<-QUERY
AzureMetrics 
| where TimeGenerated > ago(1min)
| where MetricName == "ActivitySucceededRuns"
| where ResourceProvider contains "Microsoft.DataFactory/factories"
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