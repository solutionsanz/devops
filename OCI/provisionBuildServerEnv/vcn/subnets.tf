# bastion subnets
resource "oci_core_subnet" "bastion_subnet_ad1" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["bastion_ad1"])}"
  display_name               = "${var.label_prefix}-bastion-subnet-ad1"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_vcn.vcn.id}"
  route_table_id             = "${oci_core_route_table.ig_route.id}"
  security_list_ids          = ["${oci_core_security_list.bastion_seclist.id}"]
  dhcp_options_id            = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label                  = "bastion1"
  prohibit_public_ip_on_vnic = "false"
  count                      = "${(var.availability_domains["bastion_ad1"] == "true") ? "1" : "0"}"
}

resource "oci_core_subnet" "bastion_subnet_ad2" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["bastion_ad2"])}"
  display_name               = "${var.label_prefix}-bastion-subnet-ad2"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_vcn.vcn.id}"
  route_table_id             = "${oci_core_route_table.ig_route.id}"
  security_list_ids          = ["${oci_core_security_list.bastion_seclist.id}"]
  dhcp_options_id            = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label                  = "bastion2"
  prohibit_public_ip_on_vnic = "false"
  count                      = "${(var.availability_domains["bastion_ad2"] == "true") ? "1" : "0"}"
}

resource "oci_core_subnet" "bastion_subnet_ad3" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["bastion_ad3"])}"
  display_name               = "${var.label_prefix}-bastion-subnet-ad3"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_vcn.vcn.id}"
  route_table_id             = "${oci_core_route_table.ig_route.id}"
  security_list_ids          = ["${oci_core_security_list.bastion_seclist.id}"]
  dhcp_options_id            = "${oci_core_vcn.vcn.default_dhcp_options_id}"
  dns_label                  = "bastion3"
  prohibit_public_ip_on_vnic = "false"
  count                      = "${(var.availability_domains["bastion_ad3"] == "true") ? "1" : "0"}"
}
