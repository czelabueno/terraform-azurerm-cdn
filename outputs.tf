output "subscriptionId" {
  value = data.azurerm_subscription.current.subscription_id
}
output "resourceName" {
  value = azurerm_cdn_endpoint.iacexample.name
}
output "resourceGroup" {
  value = azurerm_cdn_endpoint.iacexample.resource_group_name
}
output "resourceId" {
  value = azurerm_cdn_endpoint.iacexample.id
}

output "endPoint" {
  value = "https://${azurerm_cdn_endpoint.iacexample.name}.azureedge.net"
}