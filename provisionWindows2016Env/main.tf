# Install a simple Ubuntu VM into Oracle IaaS
# 
# Thanks to Camerone Senese for providing guidance and the original template: https://github.com/CameronSenese
#
# Note: Initial version created by: cameron.senese@oracle.com
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)

### Environment ###
  provider "opc" {
    user                = "${var.ociUser}"
    password            = "${var.ociPass}"
    identity_domain     = "${var.idDomain}"
    endpoint            = "${var.apiEndpoint}"
  }
  resource "opc_compute_ssh_key" "my-public-key" {
    name                = "${var.prefix}_my-public-key"
    key                 = "${file(var.ssh_public_key)}"
    enabled             = true
  }

### Network ###
  ### Network :: IP Network ###
    # N/A
  ### Network :: Shared Network ###
    ### Network :: Shared Network :: IP Reservation ###
    resource "opc_compute_ip_reservation" "my-reservation-ip-external" {
      parent_pool         = "/oracle/public/ippool"
      name                = "${var.prefix}_my-ip-external"
      permanent           = true
    }

    ### Network :: Custom Applications ###


    ### Network :: Shared Network :: Security Lists ###
    # A security list is a group of Oracle Compute Cloud Service instances that you can specify as the source or destination in one or more security rules. The instances in a
    # security list can communicate fully, on all ports, with other instances in the same security list using their private IP addresses.
    ###
    resource "opc_compute_security_list" "my-sec-list-1" {
      name                 = "${var.prefix}_my-sec-list-1"
      policy               = "deny"
      outbound_cidr_policy = "permit"
    }

    ### Network :: Shared Network :: Security IP Lists ###
    # A security IP list is a list of IP subnets (in the CIDR format) or IP addresses that are external to instances in OCI Classic.
    # You can use a security IP list as the source or the destination in security rules to control network access to or from Classic instances.
    ###	
    resource "opc_compute_security_ip_list" "my-sec-ip-list-1" {
      name        = "${var.prefix}_my-sec-ip-list-1-inet"
      ip_entries = [ "0.0.0.0/0" ]
    }
        
    ### Network :: Shared Network :: Security Rules ###
    # Security rules are essentially firewall rules, which you can use to permit traffic
    # between Oracle Compute Cloud Service instances in different security lists, as well as between instances and external hosts.
    ###
    resource "opc_compute_sec_rule" "my-sec-rule-1" {
      depends_on       = ["opc_compute_security_list.my-sec-list-1"]
      name             = "${var.prefix}_my-sec-rule-1"
      source_list      = "seciplist:${opc_compute_security_ip_list.my-sec-ip-list-1.name}"
      destination_list = "seclist:${opc_compute_security_list.my-sec-list-1.name}"
      action           = "permit"
      application      = "/oracle/public/ssh"
    }

    resource "opc_compute_sec_rule" "my-sec-rule-2" {
      depends_on       = ["opc_compute_security_list.my-sec-list-1"]
      name             = "${var.prefix}_my-sec-rule-2"
      source_list      = "seciplist:${opc_compute_security_ip_list.my-sec-ip-list-1.name}"
      destination_list = "seclist:${opc_compute_security_list.my-sec-list-1.name}"
      action           = "permit"
      application      = "/oracle/public/http"
    }

    resource "opc_compute_sec_rule" "my-sec-rule-3" {
      depends_on       = ["opc_compute_security_list.my-sec-list-1"]
      name             = "${var.prefix}_my-sec-rule-3"
      source_list      = "seciplist:${opc_compute_security_ip_list.my-sec-ip-list-1.name}"
      destination_list = "seclist:${opc_compute_security_list.my-sec-list-1.name}"
      action           = "permit"
      application      = "/oracle/public/https"
    }    

    resource "opc_compute_sec_rule" "my-sec-rule-4" {
      depends_on       = ["opc_compute_security_list.my-sec-list-1"]
      name             = "${var.prefix}_my-sec-rule-4"
      source_list      = "seciplist:${opc_compute_security_ip_list.my-sec-ip-list-1.name}"
      destination_list = "seclist:${opc_compute_security_list.my-sec-list-1.name}"
      action           = "permit"
      application      = "/oracle/public/rdp"
    }  

### Storage ###
  ### Storage :: Master ###
  resource "opc_compute_storage_volume" "my-volume-1" {
    size                = "20"
    description         = "${var.prefix}_my-volume-1: bootable storage volume"
    name                = "${var.prefix}_my-volume-1-boot"
    storage_type        = "/oracle/public/storage/latency"
    bootable            = true
    image_list          = "${var.imageLocation}"
    image_list_entry    = 1
  }

### Compute ###
  ### Compute :: Master ###
  resource "opc_compute_instance" "my-vm-instance-1" {
    name                = "${var.prefix}_my-vm-instance-1"
    label               = "${var.prefix}_my-vm-instance-1"
    shape               = "oc4"
    hostname            = "${var.prefix}-my-vm-instance-1"
    reverse_dns         = true
    storage {
      index             = 1
      volume            = "${opc_compute_storage_volume.my-volume-1.name}"
    }
    networking_info {
      index             = 0
      shared_network    = true
      sec_lists         = ["${opc_compute_security_list.my-sec-list-1.name}"]
      nat               = ["${opc_compute_ip_reservation.my-reservation-ip-external.name}"]
      dns               = ["${var.prefix}-my-vm-instance-1"]
    }
    ssh_keys            = ["${opc_compute_ssh_key.my-public-key.name}"]
    boot_order          = [ 1 ]
  }

  ### Output ###
  output "My_VM_Public_IP_Address" {
    value = ["${opc_compute_ip_reservation.my-reservation-ip-external.ip}"]
  }