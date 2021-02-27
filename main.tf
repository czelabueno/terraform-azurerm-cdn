terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.46.0"
    }
  }
  backend "remote" {
    organization = "devopsperu-demo"

    workspaces {
      name = "az-cdn-module"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_integer" "iacexample" {
  min = 1
  max = 10
}

resource "azurerm_resource_group" "iacexample" {
  count = local.existing_rg ? 0 : 1

  name     = upper("${var.type}_${var.stage}")
  location = "eastus2"
  tags = local.tags
}

resource "azurerm_cdn_profile" "iacexample" {
  name                = "iaccdn${random_integer.iacexample.result}"
  location            = local.existing_rg ? data.azurerm_resource_group.current.location : azurerm_resource_group.iacexample[count.index].location
  resource_group_name = local.existing_rg ? data.azurerm_resource_group.current.name : azurerm_resource_group.iacexample[count.index].name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "iacexample" {
  name                = "iaccdnendpoint${random_integer.iacexample.result}"
  profile_name        = azurerm_cdn_profile.iacexample.name
  location            = local.existing_rg ? data.azurerm_resource_group.current.location : azurerm_resource_group.iacexample[count.index].location
  resource_group_name = local.existing_rg ? data.azurerm_resource_group.current.name : azurerm_resource_group.iacexample[count.index].name
  #is_http_allowed = false
  #is_https_allowed = true

  origin {
    name      = "stacendpoint"
    host_name = var.static_endpoint
    https_port = 443
  }

  origin_host_header = var.static_endpoint
}
