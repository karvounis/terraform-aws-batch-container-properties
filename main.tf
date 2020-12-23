locals {
  env_vars_keys        = [for m in var.environment : lookup(m, "name")]
  env_vars_values      = [for m in var.environment : lookup(m, "value")]
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_env_vars_keys = sort(local.env_vars_keys)

  sorted_environment_vars = [
    for key in local.sorted_env_vars_keys :
    {
      name  = key
      value = lookup(local.env_vars_as_map, key)
    }
  ]
  final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : null

  container_property = {
    command                      = var.command
    environment                  = local.final_environment_vars
    executionRoleArn             = var.execution_role_arn
    fargatePlatformConfiguration = var.fargate_platform_configuration
    image                        = var.image
    instanceType                 = var.instance_type
    jobRoleArn                   = var.job_role_arn
    linuxParameters              = var.linux_parameters
    logConfiguration             = var.log_configuration
    memory                       = var.memory
    mountPoints                  = var.mount_points
    networkConfiguration         = var.network_configuration
    privileged                   = var.privileged
    readonlyRootFilesystem       = var.readonly_root_filesystem
    resourceRequirements         = var.resource_requirements
    secrets                      = var.secrets
    ulimits                      = var.ulimits
    user                         = var.user
    vcpus                        = var.vcpus
    volumes                      = var.volumes
  }

  json_container_property_map = jsonencode(local.container_property)
}
