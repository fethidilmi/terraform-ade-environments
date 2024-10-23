# Define the provider
provider "azurerm" {
  features {}
  subscription_id = var.ade_subscription
}

# Define variables
variable "vnet_suffix" {
  description = "Suffix for the virtual network name"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = string
}

variable "location" {
  description = "Location for the virtual network"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  type = string
}

variable "ade_env_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "ade_subscription" {
  type = string
}

variable "ade_location" {
  type = string
}

variable "ade_environment_type" {
  type = string
}

locals {
  address_space = [for cidr in split(",", var.address_space) : trim(cidr, " ")]
}

# Create the virtual network
resource "azurerm_virtual_network" "main" {
  name                = "myVNet-${var.vnet_suffix}"
  address_space       = local.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
