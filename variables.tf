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
    existing_resource_group = data.azurerm_resource_group.current.id != null?0:1
}

data "azurerm_subscription" "current" {}
data "azurerm_resource_group" "current" {
    name = upper("${var.type}_${var.stage}")
}