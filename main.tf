provider "azurerm" {
  features {}
}
# resource group for attaching all resources data.
  
resource "azurerm_resource_group" "rg" {
  name     = "${var.resourcegroup}-resources"
  location = "${var.location}"
}
#container registry for container instances.

resource "azurerm_container_registry" "cr" {
  name                = "${var.containerregistry}registry"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  sku                 = "Standard"
  tag                 = "sample code"

}
#data factory for logs.

resource "azurerm_data_factory" "datafactory" {
  name                = "${var.df}-DF"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

# storage account.

resource "azurerm_storage_account" "storage-acc" {
  name                     = "${var.storage_acc}storageacct"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Deny"
    ip_rules       = ["0.0.0.0"]
  }
}

#network profile and container instance.

resource "azurerm_virtual_network" "vnet-for-np" {
  name                = "${var.vnet}vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.subnet}subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-for-np.name
  address_prefixes     = ["10.1.0.0/24"]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "network-profile" {
  name                = "${var.network-profile}networkprofile"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  container_network_interface {
    name = "hellocnic"

    ip_configuration {
      name      = "helloipconfig"
      subnet_id = azurerm_subnet.subnet.id
    }
  }
}

resource "azurerm_container_group" "containerinstance" {
  name                = "${var.containerinstance}-mycontainer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "${var.containerinstance}-examplecont"
  os_type             = "Linux , windows"

  container {
    name   = "my-container"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "sidecar"
    image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "testing"
  }
}

# kubernetes clusters
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.kub-clusters}-k8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
