locals {
  container_property = {
    command                      = var.command
    environment                  = var.environment
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
