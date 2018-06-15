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
  
  ### APICS-DBCS Storage Containers :: Object ###
  resource "opc_storage_container" "my-container-1" {
    name = "${var.prefix}_apicsDB_storage-container-1"
    allowed_origins = ["*"]
  }  

  ### APICS Storage Containers :: Object ###
  resource "opc_storage_container" "my-container-2" {
    name = "${var.prefix}_apics_storage-container-1"
    allowed_origins = ["*"]
  }    

### Null-Resources ###
  ### Null-Resources :: Master ###
  resource "null_resource" "my-apicsDev-env" {
      depends_on = ["opc_storage_container.my-container-1"]
      provisioner "local-exec" {
              command = "chmod 755 scripts/provisionAPICS.sh && scripts/provisionAPICS.sh ${var.ociPass} ${var.dbaPass} ${var.wlPass} ${var.prefix} ${var.idDomainName}"
      }
  }


  ### Output ###
  output "Oracle API Platform Dev Environment" {
    value = ["Provisioning accepted... You can review the API Platform provisioning status with: psm APICS operation-status -j [JOB_ID]"]
  }