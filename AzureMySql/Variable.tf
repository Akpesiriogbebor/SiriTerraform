variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default    = "Ensono"
  
}

variable "monitor_diagnostic_setting" {
  description = "Name of the storage diagnostics setting"
  default    = "testing3432"
  
}

variable "appservice" {
  description = "Name of the storage account"
  default    = "Ensonoapp"
  
}
variable "log_analytics_workspace" {
  description = "Name of the log_analytics_workspace"
  default    = "test"
  
}

variable "location" {
  description = "Name of the log_analytics_workspace"
  default    = "East US"
  
}