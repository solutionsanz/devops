# Identity and access parameters
variable "tenancy_ocid" {
  type = "string"
  description = "tenancy id"
}

variable "user_ocid" {
  type = "string"
  description = "user ocid"
}

variable "compartment_ocid" {
  type = "string"
  description = "compartment ocid"
}

variable "api_fingerprint" {
  description = "fingerprint of oci api private key"
}

variable "api_private_key_path" {
  description = "path to oci api private key"
}

variable "ssh_private_key_path" {
  description = "path to ssh private key"
}
variable "ssh_public_key_path" {
  description = "path to ssh public key"
}

# general oci parameters

variable "region" {
  # List of regions: https://docs.us-phoenix-1.oraclecloud.com/Content/General/Concepts/regions.htm
  description = "region"
  default     = "us-ashburn-1"
}

variable "disable_auto_retries" {
  default = "true"
}

variable "label_prefix" {
  type    = "string"
  default = ""
}

# network parameters
variable "vcn_dns_name" {
  type    = "string"
  default = "baseoci"
}

variable "vcn_name" {
  type    = "string"
  description = "name of vcn"
}

variable "vcn_cidr" {
  type    = "string"
  description = "cidr block of VCN"
  default     = "10.0.0.0/16"
}

variable "newbits" {
  type    = "string"
  description = "new mask for the subnet within the virtual network. use as newbits parameter for cidrsubnet function"
  default     = "8"
}

variable "subnets" {
  type        = "map"
  description = "zero-based index of the subnet when the network is masked with the newbit."

  default = {
    bastion_ad1 = "11"
    bastion_ad2 = "21"
    bastion_ad3 = "31"
  }
}

# compute
variable "imageocids" {
  type = "map"

  default = {
    # https://docs.us-phoenix-1.oraclecloud.com/images/
    # updated to Oracle-Linux-7.6-2018.11.19-0
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaaaujbtv32uv4mizzbgnjkjlvbeaiqj5sgc6r5umfunebt7qpzdzmq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaa2mnepqp7wn3ej2axm2nkoxwwcdwf7uc246tcltg4li67z6mktdiq"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa2rvnnmdz6ewn4pozatb2l6sjtpqpbgiqrilfh3b4ee7salrwy3kq"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaaikjrglbnzkvlkiltzobfvtxmqctoho3tmdcwopnqnoolmwbsk3za"
  }
}

variable "bastion_shape" {
  description = "shape of bastion instance"
  default     = "VM.Standard1.1"
}

# availability domains

variable "availability_domains" {
  description = "ADs where to provision resources"
  type        = "map"

  default = {
    bastion_ad1 = "false"
    bastion_ad2 = "false"
    bastion_ad3 = "false"
  }
}

# nat
variable "create_nat_gateway" {
  description = "whether to create a nat gateway"
  default = "false"
}

variable "nat_gateway_name" {
  description = "display name of the nat gateway"
  default = "nat"
}

# service gateway

variable "create_service_gateway" {
  description = "whether to create a service gateway"
  default = "false"
}

variable "service_gateway_name" {
  description = "name of service gateway"
  default = "object_storage_gateway"
}