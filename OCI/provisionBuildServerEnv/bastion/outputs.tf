output "bastion_public_ips" {
  value = "${
    map(    
      "ad1","${join(",", data.oci_core_vnic.bastion_vnic_ad1.*.public_ip_address)}",
      "ad2","${join(",", data.oci_core_vnic.bastion_vnic_ad2.*.public_ip_address)}",
      "ad3","${join(",", data.oci_core_vnic.bastion_vnic_ad3.*.public_ip_address)}"
     )  
  }"
}
