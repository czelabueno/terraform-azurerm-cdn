variable static_endpoint {
    type = string
}

variable type {
    type = string
    default = "module"
}

variable stage {
    type = string
}

locals {
    tags = {
        provisionedBy = "https://github.com/czelabueno/infrastructure-as-code-testing"
    }

    existing_rg = data.azurerm_resource_group.current.name != "" ? true : false
}

data "azurerm_subscription" "current" {}
data "azurerm_resource_group" "current" {
    name = upper("${var.type}_${var.stage}")
}