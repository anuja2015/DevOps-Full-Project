variable "subnets" {
  type = map(object({
    name = string
    address_prefix = string
    

  }))
  default = {
    "subnet1" = {
      name = "devops-subnet-01"
      address_prefix = "10.1.1.0/24" 
      
    }
    "subnet2" = {
      name =  "devops-subnet-02"
      address_prefix = "10.1.2.0/24"
      
    }
  }
}