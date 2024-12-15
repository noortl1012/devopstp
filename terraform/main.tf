provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "jenkins-tf-webapp-rg"
  location = "WestEurope"
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "jenkins-tf-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "F1"         # Free tier
  os_type  = "Linux"      # Use Linux for Node.js apps
}

# App Service (Node.js Web App)
resource "azurerm_linux_web_app" "webapp" {
  name                = "jenkins-tf-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  # Configuration to use Node.js
  site_config {
    linux_fx_version = "NODE|14-lts"  # Node.js version 14.x
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14-lts"
  }

  # Enable GitHub Deployment (or another Git provider)
  source_control {
    repository_url      = "https://github.com/noortl1012/devopstp.git"  # Change this to your GitHub repository URL
    branch              = "master"  # You can use another branch if needed
  }

  tags = {
    environment = "dev"
  }
}
