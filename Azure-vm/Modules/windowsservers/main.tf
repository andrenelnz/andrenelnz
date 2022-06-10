terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.9.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

#######################
## Windows VM - Main ##
#######################

# Retrieve the resource group for the VNET
data "azurerm_resource_group" "network-rg" {
  name     = var.azurerm_resource_group_network_rg
  #location = var.location
}

output "network-rg-id" {
  value = data.azurerm_resource_group.network-rg.id
}

# Retrieve the resource group for the resources
data "azurerm_resource_group" "resources-rg" {
  name     = var.azurerm_resource_group_resources_rg
  #location = var.location
}

output "resources-rg-id" {
  value = data.azurerm_resource_group.resources-rg.id
}

data "azurerm_subnet" "network-subnet" {
  name                 = var.azurerm_subnet_network_subnet
  virtual_network_name = var.azurerm_subnet_network_name
  resource_group_name  = var.azurerm_resource_group_network_rg
}

output "subnet_id" {
  value = data.azurerm_subnet.network-subnet.id
}

# Create Network Card for VM
resource "azurerm_network_interface" "windows-vm-nic" {
  name                      = "${var.windows-vm-hostname}-nic"
  location                  = data.azurerm_resource_group.network-rg.location
  resource_group_name       = data.azurerm_resource_group.resources-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags 
}
## Work in progress for static ip
/* resource "null_resource" "example2" {
  provisioner "local-exec" {
    command = "az network private-ip update -g azurerm_network_interface.windows-vm-nic.resource_group_name -n internal --allocation-method Static"
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [azurerm_network_interface.windows-vm-nic]
} */
#########

/* $vm = get-azvm -resourcegroup data.azurerm_resource_group.resources-rg.name
$networkProfile = $Vm.NetworkProfile.NetworkInterfaces.id.Split("/")|Select -Last 1
   $IPConfig = (Get-AzNetworkInterface -Name $networkProfile).IpConfigurations.PrivateIpAddress
   [pscustomobject]@{
       fqdn = $Vm.OsProfile.ComputerName
       ipaddress = $IPConfig
   }

$Nic = Get-AzNetworkInterface -ResourceGroupName "rg-iaas-resources-dev" -Name "tfwinsrv-nic"
$Nic.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
Set-AzNetworkInterface -NetworkInterface $Nic */

#########

# Create Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "windows-vm" {
  name                  = var.windows-vm-hostname
  location              = azurerm_network_interface.windows-vm-nic.location
  resource_group_name   = azurerm_network_interface.windows-vm-nic.resource_group_name
  size                  = var.windows-vm-size
  network_interface_ids = [azurerm_network_interface.windows-vm-nic.id]
  
  computer_name         = var.windows-vm-hostname
  admin_username        = var.windows-admin-username
  admin_password        = var.windows-admin-password

  os_disk {
    name                 = "${var.windows-vm-hostname}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows-2019-sku
    version   = "latest"
  }

  enable_automatic_updates = true
  provision_vm_agent       = true

  tags = var.tags
}

resource "local_file" "vm" {
    #content  = <<-EOT azurerm_virtual_network.dev.id
    content = <<-EOT
        "subnet id:" ${data.azurerm_subnet.network-subnet.id}
        "resources resource-group:" ${data.azurerm_resource_group.resources-rg.id}
        "network resource-group:" ${data.azurerm_resource_group.network-rg.id}
    EOT
    filename = "${path.module}/vm-output.txt"
}