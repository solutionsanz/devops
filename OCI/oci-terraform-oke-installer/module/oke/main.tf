### OKE ###
### OKE :: Cluster ###
resource "oci_containerengine_cluster" "cluster" {
	compartment_id = "${var.g002_compartmentOcid}"
	kubernetes_version = "${var.k009_kubeVers}"
	name = "${var.e000_envName}${var.e001_envNumber}-oke"
	vcn_id = "${var.n003_vcnId}"
	options {
		add_ons {
			is_kubernetes_dashboard_enabled = true
			is_tiller_enabled = true
		}
		kubernetes_network_config {
			#Optional
			#pods_cidr = "${var.cluster_options_kubernetes_network_config_pods_cidr}"
			#services_cidr = "${var.cluster_options_kubernetes_network_config_services_cidr}"
		}
		service_lb_subnet_ids = ["${var.n017_netLbrSubnets}"]
	}
}
### OKE :: Node Pool ###
resource "oci_containerengine_node_pool" "node_pool_1" {
	count = "${var.k001_quantityWkrSubnets == "1" ? 1 : 0}"
	cluster_id = "${oci_containerengine_cluster.cluster.id}"
	compartment_id = "${var.g002_compartmentOcid}"
	kubernetes_version = "${var.k009_kubeVers}"
	name = "${var.e000_envName}${var.e001_envNumber}-oke"
	node_image_name = "${var.k008_wkrNodeImage}"
	node_shape = "${var.k007_wkrNodeShape}"
  subnet_ids = ["${var.n018_netWkrSubnets01}"]
	initial_node_labels {
		#Optional
		key = "name"
		value = "${var.e000_envName}${var.e001_envNumber}-oke"
	}
	quantity_per_subnet = "${var.k002_quantityPerSubnet}"
	ssh_public_key = "${file(var.c004_rsaPublicKeyPath)}"
}
resource "oci_containerengine_node_pool" "node_pool_2" {
	count = "${var.k001_quantityWkrSubnets == "2" ? 1 : 0}"
	cluster_id = "${oci_containerengine_cluster.cluster.id}"
	compartment_id = "${var.g002_compartmentOcid}"
	kubernetes_version = "${var.k009_kubeVers}"
	name = "${var.e000_envName}${var.e001_envNumber}-oke"
	node_image_name = "${var.k008_wkrNodeImage}"
	node_shape = "${var.k007_wkrNodeShape}"
  subnet_ids = ["${var.n019_netWkrSubnets02}"]
	initial_node_labels {
		#Optional
		key = "name"
		value = "${var.e000_envName}${var.e001_envNumber}-oke"
	}
	quantity_per_subnet = "${var.k002_quantityPerSubnet}"
	ssh_public_key = "${file(var.c004_rsaPublicKeyPath)}"
}
resource "oci_containerengine_node_pool" "node_pool_3" {
	count = "${var.k001_quantityWkrSubnets == "3" ? 1 : 0}"
	cluster_id = "${oci_containerengine_cluster.cluster.id}"
	compartment_id = "${var.g002_compartmentOcid}"
	kubernetes_version = "${var.k009_kubeVers}"
	name = "${var.e000_envName}${var.e001_envNumber}-oke"
	node_image_name = "${var.k008_wkrNodeImage}"
	node_shape = "${var.k007_wkrNodeShape}"
  subnet_ids = ["${var.n020_netWkrSubnets03}"]
	initial_node_labels {
		#Optional
		key = "name"
		value = "${var.e000_envName}${var.e001_envNumber}-oke"
	}
	quantity_per_subnet = "${var.k002_quantityPerSubnet}"
	ssh_public_key = "${file(var.c004_rsaPublicKeyPath)}"
}

### OKE :: Kubeconfig ###
data "oci_containerengine_cluster_kube_config" "kube_config" {
	cluster_id = "${oci_containerengine_cluster.cluster.id}"
	#Optional
	#expiration = "${var.cluster_kube_config_expiration}"
	#token_version = "${var.cluster_kube_config_token_version}"
}
