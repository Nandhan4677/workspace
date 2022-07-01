variable "prefix" {
    name = "container"
  description = "The prefix used for all resources in this example"
}

variable "location" {
    value = "East us"
  description = "The Azure location where all resources in this example should be created"
}

variable "df" {
    name = "mydatafactory"
  description = "name of datafactory."
}
variable "storage_acc" {
    name = "mystorage"
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
    value = "East us"
  description = "The Azure Region in which all resources in this example should be created."
}