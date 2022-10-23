provider "azurerm" {
    version = "2.92.0"
    features {
          }  
}

terraform {
  backend "azurerm" {
    resource_group_name = ""
    storage_account_name = ""
    container_name = ""
    key = ""
  }
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location =   "east us"
}

resource "azurerm_container_group" "tfcg_test" {
    name = "weatherapi"  
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "public"
    dns_name_label = "slashme101apitf"
    os_type = "Linux"

    container {
        name = "weatherapi"
        image = "slashme101/weatherapi"
          cpu = "1"
          memory = "1"

          ports {
            port = 80
            protocol = "TCP"
          }
    }
}