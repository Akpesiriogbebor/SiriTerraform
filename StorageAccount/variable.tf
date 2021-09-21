variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default    = "TestRG"
  
}

variable "location" {
  description = "The location/region where we are crrating the resource"
  default     = "East US 2"
}

variable "actiongroupid" {
  description = "actiongroupname"
  default    =  "Test"
}

variable "scopes" {
  description = "scope of the resource"
  type = list(string)
  default = ["/subscriptions/b8c277f7-258d-452c-b9ce-3b450a222e7b/resourceGroups/TestResponse/providers/Microsoft.Storage/storageAccounts/test8871"]
}