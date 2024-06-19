variable "nw_name" {
  type        = string
  description = "The name of the Network Watcher. Changing this forces a new resource to be created"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "la_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'"
}

variable "la_sku" {
  type        = string
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018"
}

variable "nwfl_name" {
  type        = string
  description = "The name of the Network Watcher Flow Log. Changing this forces a new resource to be created"
}

variable "nwfl_nsg_id_1" {
  description = "The ID of the VM Network Security Group to attach the Flow Log to"
}

variable "nwfl_nsg_id_2" {
  description = "The ID of the AKS Network Security Group to attach the Flow Log to"
}

variable "nwfl_sa_id" {
  description = "The ID of the Storage Account to send the Flow Log to"
}

variable "nwfl_enabled" {
  type        = bool
  description = "Should Network Flow Logging be Enabled?"
}

variable "nwfl_rp_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable retention"
}

variable "nwfl_rp_days" {
  type        = number
  description = "The number of days to retain flow log records"
}

variable "nwfl_ta_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable traffic analytics"
}

variable "nwfl_ta_interval" {
  type        = number
  description = "How frequently service should do flow analytics in minutes. Defaults to 60"
}