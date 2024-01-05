terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

resource "azurerm_resource_group" "devops-rg" {
    name = "devops-RG"
    location = "eastus2"
  
}

resource "azurerm_linux_virtual_machine" "devopsvm" {
    for_each = var.devopsVMs
    name = each.value.name
    resource_group_name = azurerm_resource_group.devops-rg.name
    location = azurerm_resource_group.devops-rg.location
    size = "Standard_B1s"
    source_image_reference {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "22.04.202311010"
    }
    admin_username = "azureuser"
    admin_ssh_key {
        username = "azureuser"
        public_key = file("~/.ssh/id_rsa.pub")
      
    }
    os_disk {
      storage_account_type = "Premium_LRS"
      caching = "ReadWrite"
    }
    network_interface_ids = [ azurerm_network_interface.devopsnic[each.key].id, ]

    depends_on = [  
      azurerm_resource_group.devops-rg, 
      ]
  
}
