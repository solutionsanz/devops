# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

resource "oci_core_security_list" "compute_seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.label_prefix}-compute-security-list"
  vcn_id         = "${oci_core_vcn.vcn.id}"
  count          = "${((var.availability_domains["compute_ad1"] == "true")||(var.availability_domains["compute_ad2"] == "true")||(var.availability_domains["compute_ad3"] == "true")) ? "1" : "0"}"

  egress_security_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
    },
  ]

  ingress_security_rules = [
    {
      protocol = "all"
      source   = "${var.vcn_cidr}"
    },
    {
      # allow ssh
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
  ]
}

# resource "oci_core_security_list" "service_gateway_security_list" {
#   compartment_id = "${var.compartment_ocid}"
#   vcn_id         = "${oci_core_vcn.vcn.id}"
#   display_name   = "${var.label_prefix}-service-security-list"

#   egress_security_rules {
#     destination      = "${lookup(data.oci_core_services.oci_services_object_storage.services[0], "cidr_block")}"
#     destination_type = "SERVICE_CIDR_BLOCK"
#     protocol         = "6"

#     tcp_options {
#       max = "443"
#       min = "443"
#     }
#   }

#   ingress_security_rules {
#     protocol = "6"
#     source   = "0.0.0.0/0"

#     tcp_options {
#       max = "22"
#       min = "22"
#     }
#   }
# }
