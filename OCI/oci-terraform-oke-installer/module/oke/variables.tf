### Environment ###
variable e000_envName {}
variable e001_envNumber {}
### Geography ###
### Credentials ###
variable c004_rsaPublicKeyPath {}
### Network ###
### Network :: VCN ###
variable "g001_tenancyOcid" {}
variable "g002_compartmentOcid" {}
variable "n003_vcnId" {}
### Network :: Internet Gateway ###
### Network :: Route Table ###
### Network :: Subnet ###
variable n017_netLbrSubnets {
  type = "list"
}
variable n018_netWkrSubnets01 {
  type = "list"
}
variable n019_netWkrSubnets02 {
  type = "list"
}
variable n020_netWkrSubnets03 {
  type = "list"
}
### Network :: Security List ###
### OKE ###
variable k001_quantityWkrSubnets {}
variable k002_quantityPerSubnet {}
variable k007_wkrNodeShape {}
variable k008_wkrNodeImage {}
variable k009_kubeVers {}
### Miscellaneous ###