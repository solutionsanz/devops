# Build Kubernetes based on the Oracle Linux Container Services for use with Kubernetes.
# The current release of Oracle Linux Container Services for use with Kubernetes is based on Kubernetes
# version 1.8.4, as released upstream.
#
# Note: Initial version created by: cameron.senese@oracle.com

### Credentials ###
variable "a00_idIdcs" {
  description = "Cloud Platform Tenancy Mode: Cloud Account with IDCS (=true) or Traditional (=false)"
  default     = "true"
}

variable "ociUser" {
  description = "Username (Compute) - OCI-Classic user account with Compute_Operations rights"
}

variable "ociPass" {
  description = "Password (Compute) - OCI-Classic user account with Compute_Operations rights"
}

variable "idDomain" {
  description = "Identity Domain (Compute) - Compute Service Instance ID (IDCS)"
}

#variable "a031_idIdcsTenant" {
#  description = "IDCS tenant name"
#  default     = "insert-here.."
#  #user input: true
#  #tenancy: idcs
#  #location: compute classic | service details | additional information | identity service id
#}

variable "apiEndpoint" {
  description = "Api Endpoint (Compute) - OCI-Classic Compute tenancy REST Endpoint URL"
}

  variable "containerRepoUser" {
      description = "Username - Oracle Container Registry"
  }
  variable "a06_containerRepoPass" {
      description = "Password - Oracle Container Registry"
  }

#variable "a06_stgUser" {
#  description = "Username (Object Storage) - OCI-Classic Object Storage user account"
#  default     = "insert-here.."
#  #user input: true
#  #tenancy: idcs
#}

#variable "a07_stgPass" {
#  description = "Password (Object Storage) - OCI-Classic Object Storage user account"
#  default     = "insert-here.."
#  #user input: true
#  #tenancy: idcs
#}

#variable "a08_stgEndpointAuth" {
#  description = "Api Endpoint (Object Storage) - OCI-Classic Object Storage Auth v1 REST Endpoint URL"
#  default     = "insert-here.."
#  #user input: true
#  #tenancy: idcs
#  #location: storage classic | service details | additional information | auth v1 endpoint
#}

#variable "a09_stgEndpoint" {
#  description = "Api Endpoint (Object Storage) - OCI-Classic Object Storage REST Endpoint URL"
#  default     = "insert-here.."
#  #user input: true
#  #tenancy: idcs
#  #location: storage classic | service details | additional information | rest endpoint
#  #note: used by storage classic rest authentication (`/Storage-gse00013716` portion)
#}

### Environments ###
#variable "e00_PaasDbcs" {
#  description = "Oracle DBCS install for OMCe (version:12.1.0.2, edition:EE, shape:oc3, name:OMCe-DB)"
#  #user input: true
#  #data: `true` or `false`
#  #tenancy: idcs
#  #note: used to determine whether to install dbcs paas service
#}

#variable "e01_PaasOmce" {
#  description = "Oracle Mobile Cloud - Enterprise (template: OMCe-T, requests: 100, schema prefix: OMCEWORDEV)"
#  #user input: true
#  #data: `true` or `false`
#  #tenancy: idcs
#  #note: used to determine whether to install omce paas service
#}

#variable "e10_envName" {
#  description = "Alpha code used to name PaaS & IaaS resources.."
#  default     = "OMCe"
#  #user input: true
#  #data: string as 4 digit alpha, e.g. `OMCe`
#  #tenancy: idcs
#  #note: used to name the paas & iaas resources
#}

#variable "e10_envNumber" {
#  description = "Numeric code used to name PaaS & IaaS resources.."
#  #default     = "001"
#  #user input: true
#  #data: string as 3 digit numeral, e.g. `001`
#  #tenancy: idcs
#  #note: used to name the paas & iaas resources
#}

  variable "e00_DashMonMet" {
      description = "Enhanced Dashboard, Monitoring, and Metrics (Include K8s dashboard v1.8.1, Grafana, Heapster, & InfluxDB)"
      default     = "true"
  }
  variable "e01_Fn" {
      description = "Functions as a Service (Include Fn FaaS)"
      default     = "true"
  }
  variable "e02_Ingress" {
      description = "Kubernetes Ingress (Include Traefik Ingress and sample applications)"
      default     = "true"
  }
  variable "e03_MicroSvc" {
      description = "Microservices Environment (Include WeaveScope Dashbord and E-Commerce application)"
      default     = "true"
  }
  variable "e04_SvcMesh" {
      description = "Service Mesh (Include Istio & BookInfo application)"
      default     = "true"
  }

### Keys ###
variable s00_sshUser {
  description = "Username - Account for ssh access to the image"
  default     = "ubuntu"
  #user input: false
  #tenancy: idcs
}

variable s01_sshPrivateKey {
  description = "File location of the ssh private key"
  default     = "./ssh/myPrivate_sshKey"
  #user input: false
  #tenancy: idcs
}

variable s02_sshPublicKey {
  description = "File location of the ssh public key"
  default     = "./ssh/myPublic_sshKey.pub"
  #user input: false
  #tenancy: idcs
}

### Naming TLAs ###
variable n00_mgtName {
  description = "Master/Management/Bastion node name"
  default     = "mst"
  #user input: false
  #data: string as 3 digit alpha, e.g. `mgt`
  #tenancy: idcs
  #note: used to name the iaas resources
}
