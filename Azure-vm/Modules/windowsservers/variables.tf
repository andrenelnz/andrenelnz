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

##############
## Network ##
##############

# Network resource group name
variable "azurerm_resource_group_network_rg" {
  description = "The name of the resource group where the Virtual Network will be created"
}

variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
}

variable "network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
}

variable "azurerm_subnet_network_subnet" {
  type        = string
  description = "The subnet name where the VM will be created"
}

variable "azurerm_subnet_network_name" {
  type        = string
  description = "The Network name that contains the subnet where the VM will be created"
}  

############################
## Windows VM - Variables ##
############################

# Resources resource group name
variable "azurerm_resource_group_resources_rg" {
  description = "The name of the resource group where the Virtual Machine will be created"
}

# Windows VM Admin User
variable "windows-admin-username" {
  type        = string
  description = "Windows VM Admin User"
}

# Windows VM Admin Password
variable "windows-admin-password" {
  type        = string
  description = "Windows VM Admin Password"
  sensitive   = true
}

# Windows VM Hostname (limited to 15 characters long)
variable "windows-vm-hostname" {
  type        = string
  description = "Windows VM Hostname"
  #default     = "tfazurevm1"
}

# Windows VM Virtual Machine Size
variable "windows-vm-size" {
  type        = string
  description = "Windows VM Size"
  #default     = "Standard_B1s"
}

##############
## OS Image ##
##############

# Windows Server 2019 SKU used to build VMs
variable "windows-2019-sku" {
  type        = string
  description = "Windows Server 2019 SKU used to build VMs"
  default     = "2019-Datacenter"
}
/*
# Windows Server 2016 SKU used to build VMs
variable "windows-2016-sku" {
  type        = string
  description = "Windows Server 2016 SKU used to build VMs"
  default     = "2016-Datacenter"
}

# Windows Server 2012 R2 SKU used to build VMs
variable "windows-2012-sku" {
  type        = string
  description = "Windows Server 2012 R2 SKU used to build VMs"
  default     = "2012-R2-Datacenter"
} */