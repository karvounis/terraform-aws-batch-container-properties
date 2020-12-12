output "json_map_encoded_list" {
  description = "JSON string encoded list of container properties."
  value       = [local.json_container_property_map]
}

output "json_map_encoded" {
  description = "JSON string encoded container properties."
  value       = local.json_container_property_map
}

output "json_map_object" {
  description = "JSON map encoded container properties."
  value       = jsondecode(local.json_container_property_map)
}
