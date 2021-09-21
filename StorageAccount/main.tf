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


resource "azurerm_monitor_metric_alert" "Azure-StorageTableServices-Transactions" {
          name                = "Azure-StorageTableServices-Transactions"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage Table Services - Transactions{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"

        dynamic_criteria {
                metric_namespace = "Microsoft.Storage/storageAccounts"
                metric_name      = "transactions"
                aggregation      = "Total"
                operator         = "GreaterOrLessThan"
                alert_sensitivity        = "Medium"
                evaluation_total_count   = 4
                evaluation_failure_count = 4
        }


        action {
          
          action_group_id = azurerm_monitor_action_group.action.id  
        }
}


resource "azurerm_monitor_metric_alert" "Azure-StorageTableServices-ServerLatency" {
          name                = "Azure-StorageTableServices-ServerLatency"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage Table Services - Server Latency{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"

       dynamic_criteria {
                metric_namespace = "Microsoft.Storage/storageAccounts"
                metric_name      = "successserverlatency"
                aggregation      = "Average"
                operator         = "GreaterOrLessThan"
                alert_sensitivity        = "Medium"
                evaluation_total_count   = 4
                evaluation_failure_count = 4
      }



        action {
      
           action_group_id = azurerm_monitor_action_group.action.id

        }
}

resource "azurerm_monitor_metric_alert" "Azure-StorageQueueServices-Transactions" {
          name                = "Azure-StorageQueueServices-Transactions"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage Queue Services - Transactions{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"

        dynamic_criteria {
                metric_namespace = "Microsoft.Storage/storageAccounts"
                metric_name      = "transactions"
                aggregation      = "Total"
                operator         = "GreaterOrLessThan"
                alert_sensitivity        = "Medium"
                evaluation_total_count   = 4
                evaluation_failure_count = 4
        }

        action {
    
          action_group_id = azurerm_monitor_action_group.action.id
          
        }
}

resource "azurerm_monitor_metric_alert" "Azure-StorageQueueServices-ServerLatency" {
          name                = "Azure-StorageQueueServices-ServerLatency"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage Queue Services - Server Latency{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"

        dynamic_criteria {
                metric_namespace = "Microsoft.Storage/storageAccounts"
                metric_name      = "successserverlatency"
                aggregation      = "Average"
                operator         = "GreaterOrLessThan"
                alert_sensitivity        = "Medium"
                evaluation_total_count   = 4
                evaluation_failure_count = 4
        }

          action {
           
            action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-StorageFileServices-Transactions" {
          name                = "Azure-StorageFileServices-Transactions"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage File Services - Transactions{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"


        dynamic_criteria {
                metric_namespace = "Microsoft.Storage/storageAccounts"
                metric_name      = "transactions"
                aggregation      = "Total"
                operator         = "GreaterOrLessThan"
                alert_sensitivity        = "Medium"
                evaluation_total_count   = 4
                evaluation_failure_count = 4
        }

          action {
            action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-StorageBlobServices-Transactions" {
          name                = "Azure-StorageBlobServices-Transactions"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage Blob Services - Transactions{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"

        dynamic_criteria {
                metric_namespace = "Microsoft.Storage/storageAccounts"
                metric_name      = "transactions"
                aggregation      = "Total"
                operator         = "GreaterOrLessThan"
                alert_sensitivity        = "Medium"
                evaluation_total_count   = 4
                evaluation_failure_count = 4
        }


          action {
            action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Transactions" {
          name                = "Azure-Storage-Transactions"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - Transactions{{name.name}} exceeds the previously estimated average.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=54321 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"

     
         
        dynamic_criteria {
                metric_namespace = "Microsoft.Storage/storageAccounts"
                metric_name      = "transactions"
                aggregation      = "Total"
                operator         = "GreaterOrLessThan"
                alert_sensitivity        = "Medium"
                evaluation_total_count   = 4
                evaluation_failure_count = 4
        }

          action {
              
              action_group_id = azurerm_monitor_action_group.action.id
          }
}


resource "azurerm_monitor_metric_alert" "Azure-Storage-Successe2elatency-Testing" {
          name                = "Azure-Storage-Successe2elatency-Testing"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "{{#is_alert}} Azure Server: {{name.name}}, IP: {{name.ip}} - Azure Storage end to end latency is greater than 600 ms Please refer to the following reaction process:https://apptemetry/knowledgebase/article.aspx?id=17314{{/is_alert}}@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "Microsoft.Storage/storageAccounts"
            metric_name      = "successe2elatency"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "600"

            
         
          }


          action {
    
             action_group_id = azurerm_monitor_action_group.action.id
         }
}


/* resource "azurerm_monitor_metric_alert" "Azure-Storage-Status" {
          name                = "Azure-Storage-Status"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - Status{{name.name}} is down.Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=18738 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx"
          frequency        =  "PT5M"
          severity         =  4
          window_size      =  "PT5M"

          criteria {
            metric_namespace = "Microsoft.Storage/storageAccounts"
            metric_name      = "status"
            aggregation      = "Minimum"
            operator         = "LessThan"
            threshold        = "1"
            skip_metric_validation = "true"

            
         
          }


          action {
    action_group_id = azurerm_monitor_action_group.action.id
   

     }
}   */
/* 
resource "azurerm_monitor_metric_alert" "Azure-Storage-Filesync-FailedtoSync" {
          name                = "Azure-Storage-Filesync-FailedtoSync"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - Filesync - Failed to Sync {{name.name}}FileSync: {{name.name}}, IP: {{name.ip}} - Azure Filesync failed to sync to {{serverendpointname.name}}Please refer to the following reaction process:https://apptemetry/knowledgebase/Article.aspx?id=18417Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "Microsoft.Storage/storageAccounts"
            metric_name      = "storagesyncsyncsessionperitemerrorscount"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "200"
         
          }


          action {
    action_group_id = azurerm_monitor_action_group.action.id
   

     }
}  */

    
resource "azurerm_monitor_metric_alert" "Azure-Storage-FileServices-ServerLatency" {
          name                = "Azure-Storage-FileServices-ServerLatency"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File Services - Server Latency {{name.name}}Azure File  Service: {{name.name}}, IP: {{name.ip}} - Avg server latency is over 100ms for 1 hourPlease refer to the following reaction process:https://apptemetry/knowledgebase/article.aspx?id=17315 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "Microsoft.Storage/storageAccounts"
            metric_name      = "successserverlatency"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "100"
      
          }


          action {

            action_group_id = azurerm_monitor_action_group.action.id
          }
} 

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-800Gb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(800Gb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (800Gb) {{name.name}}Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "780000000000"
            skip_metric_validation = "true"

            
         
          }


          action {
            action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-5Tb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(5Tb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (5Tb) {{name.name}}Storage Sync Service: {{name.name}},IP:{{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "4900000000000"
            skip_metric_validation = "true"

            
         
          }


          action {
            
            action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-50Gb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(50Gb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (50Gb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "49000000000"
            skip_metric_validation = "true"           
         
          }


          action {
    action_group_id = azurerm_monitor_action_group.action.id
   

     }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-4Gb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(4Gb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (4Gb) {{name.name}}Storage Sync Service: {{name.name}}, IP: {{name.ip}} Please follow the reaction process here: https://apptemetry/knowledgebase/Article.aspx?id=18383 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "3500000000"
            skip_metric_validation = "true"            
         
          }


          action {
    action_group_id =azurerm_monitor_action_group.action.id
   

     }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-4-5Tb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(4.5Tb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (4.5Tb) {{name.name}}Storage Sync Service: {{name.name}}, IP: {{name.ip}} Please follow the reaction process here: https://apptemetry/knowledgebase/Article.aspx?id=18383 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "4400000000000"
            skip_metric_validation = "true"            
         
          }


          action {
    action_group_id = azurerm_monitor_action_group.action.id
   

     }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-3-5Tb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(3.5Tb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (3.5Tb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}} Please follow the reaction process here: https://apptemetry/knowledgebase/Article.aspx?id=18383 Alerts generate an AIM ticket, viewable here (search via CI or Alert Name): https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "3400000000000"
            skip_metric_validation = "true"            
         
          }


          action {
    action_group_id = azurerm_monitor_action_group.action.id
   

     }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-2Tb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(2Tb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (2Tb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "1900000000000"
            skip_metric_validation = "true"           
         
          }


          action {
    action_group_id = azurerm_monitor_action_group.action.id
   

     }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-2Gb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(2Gb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (2Gb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quotaa"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "1500000000"
            skip_metric_validation = "true"            
         
          }


          action {
    action_group_id = azurerm_monitor_action_group.action.id  

     }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-2-6Tb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(2.6Tb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (2.6Tb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "2500000000000"
            skip_metric_validation = "true"           
         
          }


          action {

              action_group_id = azurerm_monitor_action_group.action.id 
          }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-2-1Tb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(2.1Tb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (2.1Tb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "2000000000000"
            skip_metric_validation = "true"            
         
          }


          action {
             action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-150Gb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(150Gb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (150Gb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "140000000000"
            skip_metric_validation = "true"           
         
          }


          action {
        
            action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-120Gb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(120Gb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (120Gb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "100000000000"
            skip_metric_validation = "true"           
         
          }


          action {
            
            action_group_id = azurerm_monitor_action_group.action.id
          }
} 

resource "azurerm_monitor_metric_alert" "Azure-Storage-Fileservices-FileShareQuota-1-9Tb" {
          name                = "Azure-Storage-Fileservices-FileShareQuota(1.9Tb)"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - File services - File Share Quota (1.9Tb) {{name.name}} Storage Sync Service: {{name.name}}, IP: {{name.ip}}Please follow the reaction process here:https://apptemetry/knowledgebase/Article.aspx?id=18383Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "file"
            metric_name      = "File Share Capacity Quota"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "1800000000000"
            skip_metric_validation = "true"           
         
          }


          action {
         
            action_group_id = azurerm_monitor_action_group.action.id
          }
}

resource "azurerm_monitor_metric_alert" "Azure-Storage-Blobservicelatency" {
          name                = "Azure-Storage-Blobservicelatency"
          resource_group_name = data.azurerm_resource_group.rg.name
          scopes              = var.scopes
          description         = "Azure - Storage - Blob Service Latency {{name.name}}Azure Server: {{name.name}}, IP: {{name.ip}} - Azure Storage Account Blob services server latency is greater than 400msPlease refer to the following reaction process:https://apptemetry/knowledgebase/article.aspx?id=18022Alerts generate an AIM ticket, viewable here (search via CI or Alert Name):https://apptemetry/AIM/alertsearch.aspx@webhook-aimWebhook"
          frequency        =  "PT1H"
          severity         =  4
          window_size      =  "PT1H"

          criteria {
            metric_namespace = "Microsoft.Storage/storageAccounts"
            metric_name      = "successserverlatency"
            aggregation      = "Average"
            operator         = "GreaterThan"
            threshold        = "400"           
         
          }


          action {
         
             action_group_id = azurerm_monitor_action_group.action.id
          }
}


