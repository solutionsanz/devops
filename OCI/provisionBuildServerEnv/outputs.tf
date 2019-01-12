
# for reuse
output "vcn_id" {
  value = "${module.vcn.vcn_id}"
}

output "compute_public_ips" {
  value = "${module.compute.compute_public_ips}"
}

output "ig_route_id" {
  value = "${module.vcn.ig_route_id}"
}

output "sg_route_id" {
  value = "${module.vcn.sg_route_id}"
}

output "nat_gateway_id" {
  value = "${module.vcn.nat_gateway_id}"
}

# convenient output

output "ssh_to_compute" {
  value = "${
    map(
      "AD1", "ssh -i ${var.ssh_private_key_path} opc@${module.compute.compute_public_ips["ad1"]}",
      "AD2", "ssh -i ${var.ssh_private_key_path} opc@${module.compute.compute_public_ips["ad2"]}",
      "AD3", "ssh -i ${var.ssh_private_key_path} opc@${module.compute.compute_public_ips["ad3"]}"
    )
  }"
}