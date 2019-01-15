# Build Oracle Container Engine Cluster (OKE).
# Note: Initial version created by: cameron.senese@oracle.com

### Environment ###
variable "e000_envName" {
  description = "String used to name resources"
  default     = "dev"
  #user input: true
  #data: string as 3 digit alpha, e.g. `dev`, `prd`
  #note: used to name paas & iaas resources
}
variable "e001_envNumber" {
  description = "Numeric code used to name resources"
  default     = "001"
  #user input: true
  #data: string as 3 digit numeral, e.g. `001`
  #note: used to name paas & iaas resources
}

### Geography ###
variable "g000_ociRegion" {
  description = "Cloud Platform Region"
  default     = "us-ashburn-1"
  #ref: https://docs.us-phoenix-1.oraclecloud.com/Content/General/Concepts/regions.htm
  #user input: true
}
variable "g001_tenancyOcid" {
  description = "Cloud Platform Tenancy Identifier (Oracle Cloud ID)"
  #user input: true
}
variable "g002_compartmentOcid" {
  description = "Compute Compartment Identifier for OKE Cluster (Oracle Cloud ID)"
  #user input: true
}

### Credentials ###
variable "c001_userOcid" {
  description = "OCI User Identifier (Oracle Cloud ID)"
  #user input: true
}
variable "c002_rsaFingerprint" {
  description = "Fingerprint of the public key"
  #user input: true
}
variable "c003_rsaPrivateKeyPath" {
  description = "Path to RSA Private Key"
  #user input: true
}
variable "c004_rsaPublicKeyPath" {
  description = "Path to RSA Public Key"
  #user input: true
}

### Network ###
### Network :: VCN ###
variable "n000_vcnCidrBlock" {
  description = "Network address range assigned to VCN"
  default     = "10.0.0.0/16"
  #user input: true
}
variable "n001_vcnDisplayName" {
  description = "VCN display name"
  #default     = ""
  #user input: true
}
variable "n002_vcnDnsLabel" {
  description = "VCN DNS suffix"
  #default     = ""
  #user input: true
}

### Network :: Internet Gateway ###
variable "n005_igwDisplayName" {
  description = "Internet gateway dispaly name"
  #default     = ""
  #user input: true
}
variable "n006_igwEnabled" {
  description = "Enable/disable internet gateway"
  #default     = ""
  #user input: false
}

### Network :: Route Table ###
variable "n010_rtbDisplayName" {
  description = "RTB display name"
  #default     = ""
  #user input: false
}
variable "n011_rtbCidrBlock" {
  description = "Route Table Cidr Block"
  default     = "0.0.0.0/0"
  #user input: true
}

### Network :: Subnet ###
variable "n015_netNewbits" {
  description = "New mask for the subnet within the virtual network. Used as newbits parameter for cidrsubnet function"
  default     = "8"
  #user input: false
}
variable "n016_netSubnets" {
  description = "Zero-based index of the subnet when the network is masked with the newbit. Used as netnum parameter for cidrsubnet function"
  type        = "map"
}

### Network :: Security List ###
variable "n020_secDisplayNameLbr" {
  description = "Security List display name - Load Balancer"
  #default     = ""
  #user input: false
}
variable "n021_secDisplayNameWkr" {
  description = "Security List display name - OKE Worker Nodes"
  #default     = ""
  #user input: false
}

### OKE ###
variable "k000_clusterName" {
  description = "Display name assigned to OKE cluster"
  default     = "dev000-oke"
  #user input: true
}
variable "k001_quantityWkrSubnets" {
  description = "Number of subnets to host worker nodes"
  default     = "1"
  #user input: true
}
variable "k002_quantityPerSubnet" {
  description = "Number of worker nodes per subnet"
  default     = "1"
  #user input: true
}
variable "k007_wkrNodeShape" {
  description = "CPU/RAM allocated to worker node(s)"
  default     = "VM.Standard2.2"
  #user input: false
}
variable "k008_wkrNodeImage" {
  description = "OS image used for worker node(s)"
  default     = "Oracle-Linux-7.4"
  #user input: false
}
variable "k009_kubeVers" {
  description = "Kubernetes cluster version"
  default     = "v1.10.3"
  #user input: false
}

### Miscellaneous ###
variable "x000_disableAutoRetries" {
  description = "Terraform OCI provider behaviour on resource orchestration failure"
  default     = "false"
  #user input: false
}
