resource "azurerm_public_ip" "devops-PubIP" {
  for_each = var.devopsVMs
  name                = "${each.value.name}-IP"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name
  allocation_method   = "Static"
  depends_on = [ 
    azurerm_resource_group.devops-rg,
   ]
}
resource "azurerm_public_ip" "jenkins-master-IP" {
  name                = "jenkins-master-IP"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name
  allocation_method   = "Static"
  depends_on = [ 
    azurerm_resource_group.devops-rg,
   ]
}
resource "azurerm_network_interface" "devopsnic" {
    for_each = var.devopsVMs
    name = "${each.value.name}-nic"
    location            = azurerm_resource_group.devops-rg.location
    resource_group_name = azurerm_resource_group.devops-rg.name

  ip_configuration {
    name                          = "devops-config-ip"
    subnet_id                     = azurerm_subnet.devops-subnet["subnet1"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.devops-PubIP[each.key].id
  }
  depends_on = [ 
    azurerm_resource_group.devops-rg,
    azurerm_virtual_network.devops-network,
    azurerm_subnet.devops-subnet,
    ]
}

resource "azurerm_network_interface" "jenkins-master-nic" {
    name = "jenkins-master-nic"
    location            = azurerm_resource_group.devops-rg.location
    resource_group_name = azurerm_resource_group.devops-rg.name

  ip_configuration {
    name                          = "devops-config-ip"
    subnet_id                     = azurerm_subnet.devops-subnet["subnet1"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.jenkins-master-IP.id
  }
  depends_on = [ 
    azurerm_resource_group.devops-rg,
    azurerm_virtual_network.devops-network,
    azurerm_subnet.devops-subnet,
    ]
}
resource "azurerm_virtual_network" "devops-network" {
    name = "devops-vnetwork"
    resource_group_name = azurerm_resource_group.devops-rg.name
    location = azurerm_resource_group.devops-rg.location
    address_space = ["10.1.0.0/16"]
    depends_on = [ 
      azurerm_resource_group.devops-rg,
     ]
  
}
resource "azurerm_subnet" "devops-subnet" {
  for_each = var.subnets

  name = each.value.name
  virtual_network_name = azurerm_virtual_network.devops-network.name
  resource_group_name = azurerm_resource_group.devops-rg.name
  address_prefixes = [each.value.address_prefix]
  depends_on = [ 
    azurerm_virtual_network.devops-network,
    ]
  
}

resource "azurerm_network_security_group" "devops-nsg" {
  name                = "devops-nsg"
  location            = azurerm_resource_group.devops-rg.location
  resource_group_name = azurerm_resource_group.devops-rg.name

  security_rule {
    name                       = "ssh_access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
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
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
    security_rule {
    name                       = "http_inbound_access"
    priority                   = 3000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "ingress_acess"
    priority = "301"
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
  depends_on = [ 
    azurerm_resource_group.devops-rg
   ]
}

resource "azurerm_subnet_network_security_group_association" "subnet-associate-nsg"{
    for_each = azurerm_subnet.devops-subnet

    subnet_id = each.value.id
    network_security_group_id = azurerm_network_security_group.devops-nsg.id
    depends_on = [ 
      azurerm_virtual_network.devops-network,
      azurerm_network_security_group.devops-nsg 
      ]
}