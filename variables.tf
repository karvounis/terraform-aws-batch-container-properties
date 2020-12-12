variable "command" {
  type        = list(string)
  description = "The command that's passed to the container. This parameter maps to Cmd in the Create a container section of the Docker Remote API and the COMMAND parameter to docker run. For more information, see https://docs.docker.com/engine/reference/builder/#cmd."
  default     = []
}

variable "environment" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to the container. This is a list of maps. https://docs.aws.amazon.com/batch/latest/APIReference/API_KeyValuePair.html"
  default     = []
}

variable "execution_role_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the execution role that AWS Batch can assume. Jobs running on Fargate resources must provide an execution role. https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html"
  default     = null
}

variable "fargate_platform_configuration" {
  type = object({
    platform_version = string
  })
  description = "The platform configuration for jobs running on Fargate resources. Jobs running on EC2 resources must not specify this parameter. https://docs.aws.amazon.com/batch/latest/APIReference/API_FargatePlatformConfiguration.html"
  default     = null
}

variable "image" {
  type        = string
  description = "The image used to start a container. This string is passed directly to the Docker daemon. Images in the Docker Hub registry are available by default. Other repositories are specified with repository-url/image:tag . Up to 255 letters (uppercase and lowercase), numbers, hyphens, underscores, colons, periods, forward slashes, and number signs are allowed"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for a multi-node parallel job. All node groups in a multi-node parallel job must use the same instance type."
  default     = null
}

variable "job_role_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the IAM role that the container can assume for AWS permissions. https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html"
  default     = null
}

variable "linux_parameters" {
  type = object({
    capabilities = object({
      add  = list(string)
      drop = list(string)
    })
    devices = list(object({
      containerPath = string
      hostPath      = string
      permissions   = list(string)
    }))
    initProcessEnabled = bool
    maxSwap            = number
    sharedMemorySize   = number
    swappiness         = number
    tmpfs = list(object({
      containerPath = string
      mountOptions  = list(string)
      size          = number
    }))
  })
  description = "Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html"
  default     = null
}

variable "log_configuration" {
  type = object({
    logDriver = string
    options   = map(string)
    secretOptions = list(object({
      name      = string
      valueFrom = string
    }))
  })
  description = "The log configuration specification for the container. https://docs.aws.amazon.com/batch/latest/APIReference/API_LogConfiguration.html"
  default     = null
}

variable "memory" {
  type        = number
  description = "This parameter is deprecated and not supported for jobs run on Fargate resources, use ResourceRequirement. For jobs run on EC2 resources can specify the memory requirement using the ResourceRequirement structure. The hard limit (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed. This parameter maps to Memory in the Create a container section of the Docker Remote API and the --memory option to docker run. You must specify at least 4 MiB of memory for a job. This is required but can be specified in several places; it must be specified for each node at least once."
}

variable "mount_points" {
  type = list(object({
    containerPath = string
    sourceVolume  = string
    readOnly      = bool
  }))
  description = "The mount points for data volumes in your container. This parameter maps to Volumes in the Create a container section of the Docker Remote API and the --volume option to docker run. https://docs.aws.amazon.com/batch/latest/APIReference/API_MountPoint.html"
  default     = []
}

variable "network_configuration" {
  type = object({
    assignPublicIp = string
  })
  description = "The network configuration for jobs running on Fargate resources. Jobs running on EC2 resources must not specify this parameter. https://docs.aws.amazon.com/batch/latest/APIReference/API_NetworkConfiguration.html"
  default     = null
}

variable "privileged" {
  type        = bool
  description = "When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type."
  default     = null
}

variable "readonly_root_filesystem" {
  type        = bool
  description = "When this parameter is true, the container is given read-only access to its root file system. This parameter maps to ReadonlyRootfs in the Create a container section of the Docker Remote API and the --read-only option to docker run."
  default     = null
}

variable "resource_requirements" {
  type = list(object({
    type  = string
    value = string
  }))
  description = "The type and amount of resources to assign to a container. The supported resources include GPU, MEMORY, and VCPU. https://docs.aws.amazon.com/batch/latest/APIReference/API_ResourceRequirement.html"
  default     = []
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  description = "The secrets for the container. https://docs.aws.amazon.com/batch/latest/APIReference/API_Secret.html"
  default     = []
}

variable "ulimits" {
  type = list(object({
    name      = string
    hardLimit = number
    softLimit = number
  }))
  description = "A list of ulimits to set in the container. This parameter maps to Ulimits in the Create a container section of the Docker Remote API and the --ulimit option to docker run. This parameter isn't applicable to jobs running on Fargate resources and shouldn't be provided."
  default     = []
}

variable "user" {
  type        = string
  description = "The user name to use inside the container. This parameter maps to User in the Create a container section of the Docker Remote API and the --user option to docker run."
  default     = null
}

variable "vcpus" {
  type        = number
  description = "This parameter is deprecated and not supported for jobs run on Fargate resources, see resourceRequirement. The number of vCPUs reserved for the container. Jobs running on EC2 resources can specify the vCPU requirement for the job using resourceRequirements but the vCPU requirements can't be specified both here and in the resourceRequirement structure. This parameter maps to CpuShares in the Create a container section of the Docker Remote API and the --cpu-shares option to docker run. Each vCPU is equivalent to 1,024 CPU shares. You must specify at least one vCPU. This is required but can be specified in several places. It must be specified for each node at least once."
}

variable "volumes" {
  type = list(object({
    host = object({
      sourcePath = string
    })
    name = string
  }))
  description = "A list of data volumes used in a job. https://docs.aws.amazon.com/batch/latest/APIReference/API_Volume.html"
  default     = []
}
