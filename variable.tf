variable "resourcegroup" {
    name = "myresource-group"
  description = "resource group for all resouces"

}


variable "containerregistry" {
  name = "my-container-registry"
  description ="container registry"
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
  description = "storage account"
}

variable "containerinstance" {
  name = "my-container-instance"
  description = "The prefix used for all resources in this example"
}

variable "vnet" {
    name = "my-vnet"
  description = "vnet for network profile config"
  }

  variable "subnet" {
    name = "my-subnet"
  description = "subnet for network profile config"
  }

variable "network-profile" {
    name = "container-networkprofile"
  description = "network profile for container instance"
}

 variable "kub-cluster" {
    name = "kubernetes-cluster"
  description = "kubernetes clusters"
 }

  variable "eventhub-namespace" {
    name = "my-eventhub-namespace"
  description = "eventhub name spaces"
 }

  variable "eventhub-namespace-authorization-rule" {
    name = "my-eventhub-authorization-rule"
  description = "eventhub name spaces authorization rule"
 }

 variable "eventhub" {
    name = "my-eventhub"
  description = "eventhub"
 }

 variable "eventhub-consumer-group" {
    name = "my-eventhub-consumergroup"
  description = "eventhub"
 }