terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}
provider "azurerm" {
  features {}
}
# Resource: Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "jenkins-tf-webapp-rg"
  location = "WestEurope" # Modify this to your region
}

resource "azurerm_service_plan" "asp" {
  name                = "jenkins-tf-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "F1"         # Free tier
  os_type  = "Linux"      # Specify the operating system type
}


resource "azurerm_linux_web_app" "webapp" {
  name                = "jenkins-tf-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    linux_fx_version = "DOCKER|noortl/myapp:1.0"  # Docker container format
  }

  tags = {
    environment = "dev"
  }
}
