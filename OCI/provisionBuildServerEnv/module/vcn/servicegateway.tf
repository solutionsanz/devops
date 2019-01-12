resource "oci_core_service_gateway" "service_gateway" { 
  depends_on = ["oci_core_nat_gateway.nat_gateway"]
  compartment_id = "${var.compartment_ocid}"

  services {
    service_id = "${lookup(data.oci_core_services.oci_services_object_storage.services[0], "id")}"
  }

  vcn_id = "${oci_core_vcn.vcn.id}"

  display_name = "${var.label_prefix}-${var.service_gateway_name}"

  count = "${(var.create_service_gateway == "true") ? 1 : 0}"
}

resource "oci_core_route_table" "service_gateway_route" {
  depends_on = ["oci_core_route_table.nat_route"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn.id}"
  display_name   = "${var.label_prefix}-service_gateway_route"

  route_rules {
    destination       = "${lookup(data.oci_core_services.oci_services_object_storage.services[0], "cidr_block")}"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = "${oci_core_service_gateway.service_gateway.id}"
  }

  count = "${(var.create_service_gateway == "true") ? 1 : 0}"
}