variable "kv_name" {
  type        = string
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "kv_sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
}

variable "kv_bypass" {
  type        = string
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"
}

variable "kv_default_action" {
  type        = string
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny"
}

variable "kv_subnet_id_1" {
  type        = string
  description = "Subnet IDs which should be able to access this Key Vault"
}

variable "kv_subnet_id_2" {
  type        = string
  description = "Subnet IDs which should be able to access this Key Vault"
}