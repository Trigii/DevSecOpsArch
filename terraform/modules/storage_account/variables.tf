variable "sa_name" {
  type        = string
  description = "Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sa_account_tier" {
  type        = string
  description = ""
}

variable "sa_account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2"
}

variable "sa_account_replication_type" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created"
}

variable "sa_is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2"
}

variable "sa_default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow"
}

variable "sa_container_access_type" {
  type        = string
  description = "The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private"
}