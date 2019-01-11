variable "user_ocid" {}

variable tenancy_ocid {}

variable "api_fingerprint" {}

variable "api_private_key_path" {}

variable "ssh_private_key_path" {}
variable "ssh_public_key_path" {}

variable "compartment_ocid" {}

variable "vcn_id" {}

variable "region" {}

variable "label_prefix" {}

variable image_ocid {}

variable "availability_domains" {
  type        = "map"
}

variable bastion_shape {}

variable "bastion_subnet_ids" {
  type        = "map"
}