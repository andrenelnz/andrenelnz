# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "windowsservers" {
  source                              = "../Module/windowsservers"
  windows-admin-username              = "serveradmin"
  windows-admin-password              = "P@55w0rd!12"
  windows-vm-hostname                 = "winsrv123"
  windows-vm-size                     = "Standard_B1s"
  azurerm_subnet_network_subnet       = "subnet0"
  location                            = var.location
  azurerm_subnet_network_name         = "vnet-iaas-dev"
  azurerm_resource_group_network_rg   = "rg-iaas-vnet-dev"
  network-vnet-cidr                   = "10.6.0.0/21"
  network-subnet-cidr                 = "10.6.0.0/24"
  azurerm_resource_group_resources_rg = "rg-iaas-resources-dev"
  tags                                = var.tags
}