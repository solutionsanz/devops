data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

data "oci_core_services" "oci_services_object_storage" {
  filter {
    name   = "name"
    values = [".*Object.*Storage"]
    regex  = true
  }
    count = "${(var.create_service_gateway == "true") ? 1 : 0}"
}

data "oci_core_service_gateways" "service_gateways" {
  #Required
  compartment_id = "${var.compartment_ocid}"

  #Optional
  state  = "${var.service_gateway_state}"
  vcn_id = "${oci_core_vcn.vcn.id}"
    count = "${(var.create_service_gateway == "true") ? 1 : 0}"
}