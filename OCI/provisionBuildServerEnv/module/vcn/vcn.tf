resource "oci_core_vcn" "vcn" {
  cidr_block     = "${var.vcn_cidr}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.label_prefix}-${var.vcn_name}"
  dns_label      = "${var.vcn_dns_name}"
}

resource "oci_core_internet_gateway" "ig" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.label_prefix}-${var.vcn_name}-ig"
  vcn_id         = "${oci_core_vcn.vcn.id}"
}

resource "oci_core_route_table" "ig_route" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn.id}"
  display_name   = "${var.label_prefix}-igroute"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.ig.id}"
  }
}