# Install a simple Ubuntu VM into Oracle IaaS
# 
# Thanks to Camerone Senese for providing guidance and the original template: https://github.com/CameronSenese
#
# Note: Initial version created by: cameron.senese@oracle.com
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)

### Variable definition ###
  variable "prefix" {
      description = "Application Name prefix used to identify resources"
  }  
  variable "ociUser" {
      description = "Username - OCI-Classic user account with Compute_Operations rights"
  }
  variable "ociPass" {
      description = "Password - OCI-Classic user account with Compute_Operations rights"
  }
  variable "idDomain" {
      description = "Platform version dependent - Either tenancy ID Domain or Compute Service Instance ID"
  }
  variable "idDomainName" {
      description = "Platform version dependent - Either tenancy ID Domain or Compute Service Instance ID"
  }
  variable "apiEndpoint" {
      description = "OCI-Classic Compute tenancy REST Endpoint URL"
  }
  variable "imageLocation" {
      description = "Image Location in OCI-Classic Compute"
  }

### Keys ###
  variable ssh_user {
    description = "Username - Account for ssh access to the image"
    default     = "opc"
  }
  variable ssh_private_key {
    description = "File location of the ssh private key"
    default     = "./ssh/myPrivate_sshKey"
  }
  variable ssh_public_key {
    description = "File location of the ssh public key"
    default     = "./ssh/myPublic_sshKey.pub"
  }

    variable administratorPassword {
    description = "Windows Administrators password"
  }