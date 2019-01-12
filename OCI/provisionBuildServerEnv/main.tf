locals {
  imageocid = "${var.region}_${var.os}"
}


module "vcn" {
  source               = "./module/vcn"
  compartment_ocid     = "${var.compartment_ocid}"
  tenancy_ocid         = "${var.tenancy_ocid}"
  vcn_dns_name         = "${var.vcn_dns_name}"
  label_prefix         = "${var.label_prefix}"
  vcn_name             = "${var.vcn_name}"
  vcn_cidr             = "${var.vcn_cidr}"
  newbits              = "${var.newbits}"
  subnets              = "${var.subnets}"
  availability_domains = "${var.availability_domains}"
  create_nat_gateway   = "${var.create_nat_gateway}"
  nat_gateway_name     = "${var.nat_gateway_name}"
  create_service_gateway ="${var.create_service_gateway}"
  service_gateway_name = "${var.service_gateway_name}"
}


module "compute" {
  source               = "./module/compute"
  tenancy_ocid         = "${var.tenancy_ocid}"
  user_ocid            = "${var.user_ocid}"
  api_fingerprint      = "${var.api_fingerprint}"
  region               = "${var.region}"
  vcn_id               = "${module.vcn.vcn_id}"
  compartment_ocid     = "${var.compartment_ocid}"
  api_fingerprint      = "${var.api_fingerprint}"
  api_private_key_path = "${var.api_private_key_path}"
  ssh_public_key_path  = "${var.ssh_public_key_path}"
  ssh_private_key_path = "${var.ssh_private_key_path}"
  image_ocid           = "${var.imageocids[local.imageocid]}"
  availability_domains = "${var.availability_domains}"
  label_prefix         = "${var.label_prefix}"
  compute_shape        = "${var.compute_shape}"
  compute_subnet_ids   = "${module.vcn.compute_subnet_ids}"
}
