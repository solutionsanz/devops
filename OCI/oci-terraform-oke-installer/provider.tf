### Provider ###
### Provider :: OCI ###
provider "oci" {
  region = "${var.g000_ociRegion}"
  tenancy_ocid = "${var.g001_tenancyOcid}"
  user_ocid = "${var.c001_userOcid}"
  fingerprint = "${var.c002_rsaFingerprint}"
  private_key_path = "${var.c003_rsaPrivateKeyPath}"
  disable_auto_retries = "${var.x000_disableAutoRetries}"
}
