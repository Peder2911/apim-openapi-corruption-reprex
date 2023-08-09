terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.48.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  name     = "apimbugreprex"
  location = "westeurope"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name}-rg"
  location = local.location
}

resource "azurerm_api_management" "main" {
  name                = "${local.name}-apim"
  location            = local.location
  resource_group_name = azurerm_resource_group.main.name
  publisher_name      = "Peder Landsverk"
  publisher_email     = "peder.landsverk@soprasteria.com"
  sku_name            = "Developer_1"
}

resource "azurerm_api_management_api" "main" {
  name                  = "${local.name}-api"
  resource_group_name   = azurerm_resource_group.main.name
  api_management_name   = azurerm_api_management.main.name
  revision              = "1"
  display_name          = "Reprex API"
  path                  = "reprex"
  protocols             = ["https"]
  subscription_required = false
  import {
    content_format = "openapi"
    content_value  = file("./openapi.yaml")
  }
}
