resource "oci_core_instance" "bastion_instance_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.label_prefix}-bastion-ad1"

  source_details {
    source_type = "image"
    source_id   = "${var.image_ocid}"
  }

  shape = "${var.bastion_shape}"

  create_vnic_details {
    subnet_id              = "${var.bastion_subnet_ids["ad1"]}"
    display_name           = "${var.label_prefix}-bastion-vnic-ad1"
    hostname_label         = "bastion-ad1"

  }

  extended_metadata {
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
    user_data           = "${data.template_cloudinit_config.bastion.rendered}"
    subnet_id           = "${var.bastion_subnet_ids["ad1"]}"
    tags                = "group:bastion"
  }

  timeouts {
    create = "60m"
  }

  count = "${(var.availability_domains["bastion_ad1"] == "true") ? "1" : "0"}"
}

resource "oci_core_instance" "bastion_instance_ad2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.label_prefix}-bastion-ad2"

  source_details {
    source_type = "image"
    source_id   = "${var.image_ocid}"
  }

  shape = "${var.bastion_shape}"

  create_vnic_details {
    subnet_id              = "${var.bastion_subnet_ids["ad2"]}"
    display_name           = "${var.label_prefix}-bastion-vnic-ad2"
    hostname_label         = "bastion-ad2"

  }

  extended_metadata {
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
    user_data           = "${data.template_cloudinit_config.bastion.rendered}"
    subnet_id           = "${var.bastion_subnet_ids["ad2"]}"
    tags                = "group:bastion"
  }

  timeouts {
    create = "60m"
  }

  count = "${(var.availability_domains["bastion_ad2"] == "true") ? "1" : "0"}"
}

resource "oci_core_instance" "bastion_instance_ad3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.label_prefix}-bastion-ad3"

  source_details {
    source_type = "image"
    source_id   = "${var.image_ocid}"
  }

  shape = "${var.bastion_shape}"

  create_vnic_details {
    subnet_id              = "${var.bastion_subnet_ids["ad3"]}"
    display_name           = "bastion vnic ad3"
    hostname_label         = "bastion-ad3"
    subnet_id              = "${var.bastion_subnet_ids["ad3"]}"

  }

  extended_metadata {
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
    user_data           = "${data.template_cloudinit_config.bastion.rendered}"
    subnet_id           = "${var.bastion_subnet_ids["ad3"]}"
    tags                = "group:bastion"
  }

  timeouts {
    create = "60m"
  }

  count = "${(var.availability_domains["bastion_ad3"] == "true") ? "1" : "0"}"
}
