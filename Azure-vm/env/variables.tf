####################
# Common Variables #
####################

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  #default     = "Australia east"
}

variable "tags" {
  description = "Tags to apply on resources"
  type        = map(string)
}
