# Build Oracle Container Engine Cluster (OKE).

### Environment ###
# N/A
### Geography ###
# N/A
### Credentials ###
# N/A

### Network ###
module "network" {
  source = "./module/network"
  ### Network :: VCN ###
  g001_tenancyOcid = "${var.g001_tenancyOcid}"
  g002_compartmentOcid = "${var.g002_compartmentOcid}"
  n000_vcnCidrBlock = "${var.n000_vcnCidrBlock}"
  n001_vcnDisplayName = "${var.e000_envName}${var.e001_envNumber}-vcn"
  n002_vcnDnsLabel = "${var.e000_envName}${var.e001_envNumber}"
  ### Network :: Internet Gateway ###
  n005_igwDisplayName = "${var.e000_envName}${var.e001_envNumber}-igw"
  n006_igwEnabled = "${var.n006_igwEnabled}"
  ### Network :: Route Table ###
  n010_rtbDisplayName = "${var.e000_envName}${var.e001_envNumber}-rtb"
  n011_rtbCidrBlock = "${var.n011_rtbCidrBlock}"
  ### Network :: Subnet ###
  n015_netNewbits = "${var.n015_netNewbits}"
  n016_netSubnets = "${var.n016_netSubnets}"
  ### Network :: Security List ###
  n020_secDisplayNameLbr = "${var.e000_envName}${var.e001_envNumber}-sec-lbr"
  n021_secDisplayNameWkr = "${var.e000_envName}${var.e001_envNumber}-sec-wkr"
}

### OKE ###
module "oke" {
  source = "./module/oke"
  ### OKE :: Cluster ###

  e000_envName = "${var.e000_envName}"
  e001_envNumber = "${var.e001_envNumber}"
  g001_tenancyOcid = "${var.g001_tenancyOcid}"
  g002_compartmentOcid = "${var.g002_compartmentOcid}"
  k009_kubeVers = "${var.k009_kubeVers}"
  n003_vcnId = "${module.network.vcn-01.id}"
  n017_netLbrSubnets = ["${module.network.net-lbr-01.id}", "${module.network.net-lbr-02.id}"]
  n018_netWkrSubnets01 = ["${module.network.net-wkr-01.id}"]
  n019_netWkrSubnets02 = ["${module.network.net-wkr-01.id}", "${module.network.net-wkr-02.id}"]
  n020_netWkrSubnets03 = ["${module.network.net-wkr-01.id}", "${module.network.net-wkr-02.id}", "${module.network.net-wkr-03.id}"]
  ### OKE :: Node Pool ###
  c004_rsaPublicKeyPath = "${var.c004_rsaPublicKeyPath}"
  k001_quantityWkrSubnets = "${var.k001_quantityWkrSubnets}"
  k002_quantityPerSubnet = "${var.k002_quantityPerSubnet}"
  k007_wkrNodeShape = "${var.k007_wkrNodeShape}"
  k008_wkrNodeImage = "${var.k008_wkrNodeImage}"
}
