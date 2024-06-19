variable "acr_name" {
  description = "Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created"
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  type        = string
}

variable "acr_sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  type        = string
}

variable "acr_admin_enabled" {
  description = "Specifies whether the admin user is enabled. Defaults to false"
  type        = bool
}