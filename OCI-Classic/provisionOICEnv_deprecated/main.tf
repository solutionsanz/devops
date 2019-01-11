# Install a simple Ubuntu VM into Oracle IaaS
# 
# Thanks to Camerone Senese for providing guidance and the original template: https://github.com/CameronSenese
#
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)

### Environment ###
  provider "opc" {
    user                = "${var.ociUser}"
    password            = "${var.ociPass}"
    identity_domain     = "${var.idDomain}"
    endpoint            = "${var.apiEndpoint}"
    storage_endpoint    = "${var.storage_endpoint}"
    storage_service_id  = "${var.storage_service_id}"
  }

### Storage ###
  ### Storage Containers :: Object ###
  resource "opc_storage_container" "my-container-1" {
    name = "${var.prefix}_oicDB_storage-container-1"
    allowed_origins = ["*"]
  }  

### Null-Resources ###
  ### Null-Resources :: Master ###
  resource "null_resource" "my-oicDev-env" {
      depends_on = ["opc_storage_container.my-container-1"]
      provisioner "local-exec" {
              command = "chmod 755 scripts/provisionOIC.sh && scripts/provisionOIC.sh ${var.ociPass} ${var.dbaPass} ${var.wlPass} ${var.prefix} ${var.idDomainName} ${var.templateName} ${var.templateVersion}"
      }
  }


  ### Output ###
  output "Oracle Integration Cloud Dev Environment" {
    value = ["Provisioning accepted... You can review the OIC provisioning status with: psm IntegrationCloud operation-status -j [JOB_ID]"]
  }