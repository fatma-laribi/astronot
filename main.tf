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

    // Provisioner to dynamically generate Prometheus configuration
    provisioner "local-exec" {
      command = <<EOT
cat <<EOF > /tmp/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'example-app'
    static_configs:
      - targets: ['localhost:80']
EOF
docker cp /tmp/prometheus.yml aci-example-container-group:/etc/prometheus/prometheus.yml
EOT
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
