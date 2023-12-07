provider "azurerm" {
  features {}
}

variable "environment" {
  description = "The environment to deploy (dev, test, staging, prod)"
  type        = string
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
    image  = "fatmal/jenkinstest:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "prometheus-container"
    image  = "prom/prometheus:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 9090
      protocol = "TCP"
    }
    command = [
        "--config.file=/etc/prometheus/prometheus.yml",
      ]

    volume {
      name = "prometheus-config"
      mount_path = "/etc/prometheus/"
  }
}
  container {
    name   = "grafana-container"
    image  = "grafana/grafana:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  tags = {
    environment = var.environment
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
