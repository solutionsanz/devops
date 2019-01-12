variable "tenancy_ocid" {}

variable "compartment_ocid" {}

variable "vcn_name" {}

variable "vcn_dns_name" {}

variable "label_prefix" {}

variable "vcn_cidr" {}

variable "newbits" {}

variable "subnets" {
  type        = "map"
}

variable "availability_domains" {
  type        = "map"
}

variable "create_nat_gateway" {}

variable "nat_gateway_name" {}

variable "create_service_gateway" {}

variable "service_gateway_name" {}

variable "service_gateway_state" {
  default = "AVAILABLE"
}