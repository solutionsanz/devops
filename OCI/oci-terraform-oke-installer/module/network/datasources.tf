data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.g001_tenancyOcid}"
}