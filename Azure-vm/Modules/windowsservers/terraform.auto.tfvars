####################
# Common Variables #
####################

# Location of the resource group for the virtual network
location = "Australiaeast"

tags = {
    environment = "dev"
    project     = "IaaS"
    consultant  = "your_name"
    app_name    = "your_app_name"
  }

###########
# Network #
###########
azurerm_resource_group_network_rg = "rg-iaas-vnet-dev"
network-vnet-cidr                 = "10.6.0.0/21"
network-subnet-cidr               = "10.6.0.0/24"

azurerm_subnet_network_subnet     = "subnet0"
azurerm_subnet_network_name       = "vnet-iaas-dev"
azurerm_resource_group_network_rg = "rg-iaas-vnet-dev"

##############
# Windows VM #
##############
azurerm_resource_group_resources_rg = "rg-iaas-resources-dev"
windows-vm-hostname                 = "windows-hostname"
windows-vm-size                     = "Standard_B1s"
windows-admin-username              = "adminuser"
windows-admin-password              = "adminpassword"