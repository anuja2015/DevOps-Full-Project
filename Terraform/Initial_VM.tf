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
    name = "devopsVM"
    resource_group_name = azurerm_resource_group.devops-rg.name
    location = azurerm_resource_group.devops-rg.location
    size = "Standard_B2s"
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
    network_interface_ids = [ azurerm_network_interface.devopsnic.id, ]
  
}
resource "azurerm_public_ip" "devops-PubIP" {
  name                = "devops-IP"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "devopsnic" {
    name ="devops-nic"
    location            = azurerm_resource_group.devops-rg.location
    resource_group_name = azurerm_resource_group.devops-rg.name

  ip_configuration {
    name                          = "devops-config-ip"
    subnet_id                     = azurerm_subnet.devops-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops-PubIP.id
  }
}
resource "azurerm_virtual_network" "devops-network" {
    name = "devops-vnetwork"
    resource_group_name = azurerm_resource_group.devops-rg.name
    location = azurerm_resource_group.devops-rg.location
    address_space = ["10.0.0.0/16"]
  
}
resource "azurerm_subnet" "devops-subnet" {
  name = "devops-internal"
  virtual_network_name = azurerm_virtual_network.devops-network.name
  resource_group_name = azurerm_resource_group.devops-rg.name
  address_prefixes = ["10.0.1.0/24"]
}


resource "azurerm_network_security_group" "devops-nsg" {
  name                = "devops-nsg1"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name

  security_rule {
    name                       = "ssh_access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "http_access"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "Apache_access"
    priority                   = 103
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8080"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}
resource "azurerm_subnet_network_security_group_association" "subnet-associate-nsg" {
  subnet_id                 = azurerm_subnet.devops-subnet.id
  network_security_group_id = azurerm_network_security_group.devops-nsg.id
}
