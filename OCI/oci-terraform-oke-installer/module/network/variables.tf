### Environment ###
### Geography ###
### Credentials ###
### Network ###
### Network :: VCN ###
variable "g001_tenancyOcid" {}
variable "g002_compartmentOcid" {}
variable "n000_vcnCidrBlock" {}
variable "n001_vcnDisplayName" {}
variable "n002_vcnDnsLabel" {}
### Network :: Internet Gateway ###
variable "n005_igwDisplayName" {}
variable "n006_igwEnabled" {}
### Network :: Route Table ###
variable "n010_rtbDisplayName" {}
variable "n011_rtbCidrBlock" {}
### Network :: Subnet ###
variable n015_netNewbits {}
variable n016_netSubnets {
  type = "map"
}
### Network :: Security List ###
variable n020_secDisplayNameLbr {}
variable n021_secDisplayNameWkr {}
### Miscellaneous ###
