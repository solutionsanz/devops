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


### Null-Resources ###
  ### Null-Resources :: Cloud Stack Env ###
  resource "null_resource" "my-stack-env-provisioning" {
      provisioner "local-exec" {
        command = "chmod 755 scripts/createStack.sh && scripts/createStack.sh ${var.ociPass} ${var.dbaPass} ${var.wlPass} ${var.idDomainName} ${var.stackName} ${var.stackTemplateVersion} ${var.wait_until_complete}"
                                                                        
      }
      provisioner "local-exec" {
        when = "destroy"
          command = "chmod 755 scripts/deleteStack.sh && scripts/deleteStack.sh ${var.dbaPass} ${var.stackName}"
      }      
  }


    ### Null-Resources :: Cloud Stack Env ###
  resource "null_resource" "my-stack-env-provisioning" {
      depends_on = ["null_resource.my-container-1"]
      provisioner "local-exec" {
        command = " if [ ${var.wait_until_complete} == 'true' ]; then chmod 755 scripts/bootstrap.sh && scripts/bootstrap.sh ${var.ociPass} ${var.dbaPass} ${var.wlPass} ${var.idDomainName} ${var.stackName} ${var.stackTemplateVersion}; else echo 'Skipping OIC bootstrap as we are not waiting for stack to be provisioned'; fi"
                                                                        
      }
      provisioner "local-exec" {
        when = "destroy"
          #command = "chmod 755 scripts/deleteStack.sh && scripts/deleteStack.sh ${var.dbaPass} ${var.stackName}"
      }      
  }


  ### Output ###
  output "Oracle Stack Environment" {
    value = ["Provisioning accepted... You can review the Stack provisioning status with: psm stack operation-status -j [JOB_ID]"]
  }