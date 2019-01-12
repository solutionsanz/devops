# compute subnets
resource "oci_core_subnet" "compute_subnet_ad1" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["compute_ad1"])}"
  display_name               = "${var.label_prefix}-compute-subnet-ad1"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_vcn.vcn.id}"
  route_table_id             = "${oci_core_route_table.ig_route.id}"
  security_list_ids          = ["${oci_core_security_list.compute_seclist.id}"]
  dhcp_options_id            = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label                  = "compute1"
  prohibit_public_ip_on_vnic = "false"
  count                      = "${(var.availability_domains["compute_ad1"] == "true") ? "1" : "0"}"
}

resource "oci_core_subnet" "compute_subnet_ad2" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["compute_ad2"])}"
  display_name               = "${var.label_prefix}-compute-subnet-ad2"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_vcn.vcn.id}"
  route_table_id             = "${oci_core_route_table.ig_route.id}"
  security_list_ids          = ["${oci_core_security_list.compute_seclist.id}"]
  dhcp_options_id            = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label                  = "compute2"
  prohibit_public_ip_on_vnic = "false"
  count                      = "${(var.availability_domains["compute_ad2"] == "true") ? "1" : "0"}"
}

resource "oci_core_subnet" "compute_subnet_ad3" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["compute_ad3"])}"
  display_name               = "${var.label_prefix}-compute-subnet-ad3"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_vcn.vcn.id}"
  route_table_id             = "${oci_core_route_table.ig_route.id}"
  security_list_ids          = ["${oci_core_security_list.compute_seclist.id}"]
  dhcp_options_id            = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label                  = "compute3"
  prohibit_public_ip_on_vnic = "false"
  count                      = "${(var.availability_domains["compute_ad3"] == "true") ? "1" : "0"}"
}
