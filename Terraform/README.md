
# Terraform

Here we will be using terraform to create resources in Azure Cloud.

### Azure provider for terraform

    terraform {
      required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "3.85.0"
        }
      }
    }

    provider "azurerm" {
      features{}
      skip_provider_registration = "true"
    }

### Terraform to create a virtual machine in Azure.

1. Create a resource group
2. Create a public IP
3. Create virtual machine and associate with the above.

### AWS VPC vs Azure Virtual Network.

|AWS VPC| AZURE VIRTUAL NETWORK|
|-------|----------------------|
| Virtual Private Cloud   | Virtual Network|
| Subnet mapped to Availability zones | Subnet defined by block of IP address assigned|
|Subnet public or private | public by default|
| creates default VPC| No default Vnet|
| Elastic IP | Public IP|
|smallest subnet is /28 and largest is /16|smallest subnet is /29 and largest is /8|
|subnet must be associated with a route table, else uses main routing table| Dont have to configure route table, by default uses system route|
| 2 levels of security - Security group , Network Access Control | Network Security group|
| multiple SG's applied to Elastic Network Interface| Only one NSG applied to a NIC|
|Connectivity to internet-Internet Gateway(subnet), NAT Gateway| Connectivity to internet and VNet to VNet - VPN Gateway, ExpressRoute and gateway subnet|
|Hybrid connectivity -Direct Connect| ExpressRoute |


### Terraform to create Virtual Network and a VM in that network.





