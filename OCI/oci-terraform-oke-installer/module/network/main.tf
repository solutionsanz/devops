### Network ###
### Network :: VCN ###
resource "oci_core_vcn" "vcn-01" {
	cidr_block = "${var.n000_vcnCidrBlock}"
	compartment_id = "${var.g002_compartmentOcid}"
	display_name = "${var.n001_vcnDisplayName}"
	dns_label = "${var.n002_vcnDnsLabel}"
}
### Network :: Internet Gateway ###
resource "oci_core_internet_gateway" "igw-01" {
	compartment_id = "${var.g002_compartmentOcid}"
	vcn_id = "${oci_core_vcn.vcn-01.id}"
	display_name = "${var.n005_igwDisplayName}"
	enabled = "${var.n006_igwEnabled}"
}
### Network :: Route Table ###
resource "oci_core_route_table" "rtb-01" {
	compartment_id = "${var.g002_compartmentOcid}"
	route_rules {
		destination = "${var.n011_rtbCidrBlock}"
		network_entity_id = "${oci_core_internet_gateway.igw-01.id}"
	}
	vcn_id = "${oci_core_vcn.vcn-01.id}"
	display_name = "${var.n010_rtbDisplayName}"
}
### Network :: Subnet ###
resource "oci_core_subnet" "net-lbr-01" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${cidrsubnet(var.n000_vcnCidrBlock,var.n015_netNewbits,var.n016_netSubnets["lbr-ad1"])}"
  display_name        = "net-lbr-01-ad1"  #variablise..
  compartment_id      = "${var.g002_compartmentOcid}"
  vcn_id              = "${oci_core_vcn.vcn-01.id}"
  route_table_id             = "${oci_core_route_table.rtb-01.id}"
  security_list_ids          = ["${oci_core_security_list.sec-01.id}"]
  dns_label                  = "lbr1"     #variablise..
  prohibit_public_ip_on_vnic = false
}
resource "oci_core_subnet" "net-lbr-02" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${cidrsubnet(var.n000_vcnCidrBlock,var.n015_netNewbits,var.n016_netSubnets["lbr-ad2"])}"
  display_name        = "net-lbr-01-ad2"  #variablise..
  compartment_id      = "${var.g002_compartmentOcid}"
  vcn_id              = "${oci_core_vcn.vcn-01.id}"
  route_table_id             = "${oci_core_route_table.rtb-01.id}"
  security_list_ids          = ["${oci_core_security_list.sec-01.id}"]
  dns_label                  = "lbr2"     #variablise..
  prohibit_public_ip_on_vnic = false
}
resource "oci_core_subnet" "net-wkr-01" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${cidrsubnet(var.n000_vcnCidrBlock,var.n015_netNewbits,var.n016_netSubnets["wkr-ad1"])}"
  display_name        = "net-wkr-01-ad1"  #variablise..
  compartment_id      = "${var.g002_compartmentOcid}"
  vcn_id              = "${oci_core_vcn.vcn-01.id}"
  route_table_id             = "${oci_core_route_table.rtb-01.id}"
  security_list_ids          = ["${oci_core_security_list.sec-02.id}"]
  dns_label                  = "wkr1"     #variablise..
  prohibit_public_ip_on_vnic = false
}
resource "oci_core_subnet" "net-wkr-02" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${cidrsubnet(var.n000_vcnCidrBlock,var.n015_netNewbits,var.n016_netSubnets["wkr-ad2"])}"
  display_name        = "net-wkr-01-ad2"  #variablise..
  compartment_id      = "${var.g002_compartmentOcid}"
  vcn_id              = "${oci_core_vcn.vcn-01.id}"
  route_table_id             = "${oci_core_route_table.rtb-01.id}"
  security_list_ids          = ["${oci_core_security_list.sec-02.id}"]
  dns_label                  = "wkr2"     #variablise..
  prohibit_public_ip_on_vnic = false
}
resource "oci_core_subnet" "net-wkr-03" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${cidrsubnet(var.n000_vcnCidrBlock,var.n015_netNewbits,var.n016_netSubnets["wkr-ad3"])}"
  display_name        = "net-wkr-01-ad3"  #variablise..
  compartment_id      = "${var.g002_compartmentOcid}"
  vcn_id              = "${oci_core_vcn.vcn-01.id}"
  route_table_id             = "${oci_core_route_table.rtb-01.id}"
  security_list_ids          = ["${oci_core_security_list.sec-02.id}"]
  dns_label                  = "wkr3"     #variablise..
  prohibit_public_ip_on_vnic = false
}
### Network :: Security List ###
resource "oci_core_security_list" "sec-01" {
  compartment_id = "${var.g002_compartmentOcid}"
  display_name   = "${var.n020_secDisplayNameLbr}"
  vcn_id         = "${oci_core_vcn.vcn-01.id}"
    egress_security_rules = [
  		{
      protocol    = "all"
      destination = "0.0.0.0/0"
      stateless   = "true"
      },
  	]
    ingress_security_rules = [
      {
        protocol  = "6"
        source    = "0.0.0.0/0"
        stateless = "true"
      },
    ]
  }
resource "oci_core_security_list" "sec-02" {
  compartment_id = "${var.g002_compartmentOcid}"
  display_name   = "${var.n021_secDisplayNameWkr}"
  vcn_id         = "${oci_core_vcn.vcn-01.id}"
    egress_security_rules = [
      {
        protocol    = "all"
        destination = "${var.n000_vcnCidrBlock}"
        stateless   = "true"
      },
      {
        protocol    = "all"
        destination = "0.0.0.0/0"
        stateless   = "false"
      },
    ]
    ingress_security_rules = [
      {
        #rules 1-3
        protocol  = "all"
        source    = "${var.n000_vcnCidrBlock}"
        stateless = "true"
      },
      {
        #rule 4
        protocol  = "1"
        source    = "0.0.0.0/0"
        stateless = "false"
      },
      {
        #rule 5
        protocol  = "6"
        source    = "130.35.0.0/16"
        stateless = "false"

        tcp_options {
          "max" = 22
          "min" = 22
        }
      },
      {
        #rule 6
        protocol  = "6"
        source    = "138.1.0.0/17"
        stateless = "false"

        tcp_options {
          "max" = 22
          "min" = 22
        }
      },
      {
        # rule 7
        protocol  = "6"
        source    = "0.0.0.0/0"
        stateless = "false"

        tcp_options {
          "max" = 22
          "min" = 22
        }
      },
      {
        # rule 8
        protocol  = "6"
        source    = "0.0.0.0/0"
        stateless = "false"

        tcp_options {
          "max" = 32767
          "min" = 3000
        }
      },
    ]
}