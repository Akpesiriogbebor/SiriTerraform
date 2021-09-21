variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default    = "TestResponse"
  
}

variable "monitor_diagnostic_setting" {
  description = "Name of the storage diagnostics setting"
  default    = "storagelogs"
  
}

variable "storage_account" {
  description = "Name of the storage account"
  default    = "test8890"
  
}

variable "log_analytics_workspace" {
  description = "Name of the log_analytics_workspace"
  default    = "adenlogworkspace"
  
}

variable "location" {
  description = "Name of the log_analytics_workspace"
  default    = "East US"
  
}