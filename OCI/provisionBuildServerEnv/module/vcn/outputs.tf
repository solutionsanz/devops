output "vcn_id" {
  value = "${oci_core_vcn.vcn.id}"
}

output "compute_subnet_ids" {
  value = "${
    map(    
      "ad1","${join(",", oci_core_subnet.compute_subnet_ad1.*.id)}",
      "ad2","${join(",", oci_core_subnet.compute_subnet_ad2.*.id)}",
      "ad3","${join(",", oci_core_subnet.compute_subnet_ad3.*.id)}"
     )  
  }"
}

output "ig_route_id" {
  value = "${oci_core_route_table.ig_route.id}"
}

output "nat_gateway_id" {
  value = "${join(",", oci_core_nat_gateway.nat_gateway.*.id)}"
}

output "sg_route_id" {
  value = "${oci_core_route_table.service_gateway_route.*.id}"
}