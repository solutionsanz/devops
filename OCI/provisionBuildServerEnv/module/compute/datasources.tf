data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

data "template_file" "compute_template" {
  template = "${file("${path.module}/scripts/compute.template.sh")}"
  count    = "${var.availability_domains["compute_ad1"] == "true" || var.availability_domains["compute_ad2"] == "true" || var.availability_domains["compute_ad3"] == "true"   ? "1" : "0"}"
}

data "template_file" "oci_config" {
  template = "${file("${path.module}/resources/ociconfig")}"

  vars = {
    user_ocid       = "${var.user_ocid}"
    api_fingerprint = "${var.api_fingerprint}"
    tenancy_ocid    = "${var.tenancy_ocid}"
    region          = "${var.region}"
  }

  count = "${var.availability_domains["compute_ad1"] == "true" || var.availability_domains["compute_ad2"] == "true" || var.availability_domains["compute_ad3"] == "true"   ? "1" : "0"}"
}

data "template_file" "api_private_key" {
  template = "${file(var.api_private_key_path)}"
}

data "template_file" "compute_cloud_init_file" {
  template = "${file("${path.module}/cloudinit/compute.template.yaml")}"

  vars = {
    compute_sh_content      = "${base64gzip(data.template_file.compute_template.rendered)}"
    api_private_key_content = "${base64gzip(data.template_file.api_private_key.rendered)}"
    oci_config_content      = "${base64gzip(data.template_file.oci_config.rendered)}"
  }

  count = "${var.availability_domains["compute_ad1"] == "true" || var.availability_domains["compute_ad2"] == "true" || var.availability_domains["compute_ad3"] == "true"   ? "1" : "0"}"
}

# cloud init for compute
data "template_cloudinit_config" "compute" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "compute.yaml"
    content_type = "text/cloud-config"
    content      = "${data.template_file.compute_cloud_init_file.rendered}"
  }

  count = "${var.availability_domains["compute_ad1"] == "true" || var.availability_domains["compute_ad2"] == "true" || var.availability_domains["compute_ad3"] == "true"   ? "1" : "0"}"
}

# Gets a list of VNIC attachments on the compute instance in AD 1
data "oci_core_vnic_attachments" "compute_vnics_attachments_ad1" {
  count               = "${(var.availability_domains["compute_ad1"] == "true") ? "1" : "0"}"
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  instance_id         = "${oci_core_instance.compute_instance_ad1.id}"
}

# Gets the OCID of the first (default) VNIC on the compute instance in AD 1
data "oci_core_vnic" "compute_vnic_ad1" {
  count   = "${(var.availability_domains["compute_ad1"] == "true") ? "1" : "0"}"
  vnic_id = "${lookup(data.oci_core_vnic_attachments.compute_vnics_attachments_ad1.vnic_attachments[0],"vnic_id")}"
}

# Gets a list of VNIC attachments on the compute instance in AD 2
data "oci_core_vnic_attachments" "compute_vnics_attachments_ad2" {
  count               = "${(var.availability_domains["compute_ad2"] == "true") ? "1" : "0"}"
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  instance_id         = "${oci_core_instance.compute_instance_ad2.id}"
}

# Gets the OCID of the first (default) VNIC on the compute instance in AD 2
data "oci_core_vnic" "compute_vnic_ad2" {
  count   = "${(var.availability_domains["compute_ad2"] == "true") ? "1" : "0"}"
  vnic_id = "${lookup(data.oci_core_vnic_attachments.compute_vnics_attachments_ad2.vnic_attachments[0],"vnic_id")}"
}

# Gets a list of VNIC attachments on the compute instance in AD 3
data "oci_core_vnic_attachments" "compute_vnics_attachments_ad3" {
  count               = "${(var.availability_domains["compute_ad3"] == "true") ? "1" : "0"}"
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  instance_id         = "${oci_core_instance.compute_instance_ad3.id}"
}

# Gets the OCID of the first (default) VNIC on the compute instance in AD 3
data "oci_core_vnic" "compute_vnic_ad3" {
  count   = "${(var.availability_domains["compute_ad3"] == "true") ? "1" : "0"}"
  vnic_id = "${lookup(data.oci_core_vnic_attachments.compute_vnics_attachments_ad3.vnic_attachments[0],"vnic_id")}"
}
