resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn.id}"
  display_name   = "${var.label_prefix}-${var.nat_gateway_name}"
  count          = "${(var.create_nat_gateway == "true") ? "1" : "0"}"
}
