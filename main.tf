provider "azurerm" {
   features {}
}

resource "azurerm_resource_group" "example" {
  name     = "aci-example-rg"
  location = "East US"
}

resource "azurerm_container_group" "example" {
  name                = "aci-example-container-group"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"

  container {
    name   = "example-container"
    image  = "fatmal/jenkinstest:latest"  # Use the desired Docker image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}

resource "azurerm_public_ip" "example" {
  name                = "aci-example-public-ip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = {
    environment = "testing"
  }
}

output "public_ip_address" {
  value = azurerm_container_group.example.ip_address
}
