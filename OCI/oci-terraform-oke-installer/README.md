[terraform]: https://terraform.io
[oci]: https://cloud.oracle.com/en_US/cloud-infrastructure
[oke]: https://cloud.oracle.com/containers/kubernetes-engine
[oci-provider]: https://www.terraform.io/docs/providers/oci/index.html
[oci-signup]: https://cloud.oracle.com/tryit
[kubectl]: https://kubernetes.io/docs/tasks/tools/install-kubectl/
[ocs-k]:https://docs.oracle.com/cd/E52668_01/E88884/html/pref.html

# Terraform Installer for Oracle OKE (Container Engine for Kubernetes)

## About

This Terraform based installer for [Oracle Container Engine for Kubernetes][oke] provides a Terraform managed Kubernetes installation for the [Oracle Cloud Infrstructure][oci] platform.

The installer utilises the [Terraform OCI Provider][oci-provider].
It consists of two Terraform modules which work in concert to automatically provision the OCI tenancy with the required networking and security components, and creates a highly available OKE managed Kubernetes cluster.

The installation includes the Kubernetes dashboard and the [Helm](https://helm.sh/) software package manager for Kubernetes.

The installer provides the ability to easily determine the dimensions of the cluster deployment, including the cluster version, compute worker node characteristics, and deployment topology (detailled below).

## Cluster Overview

Terraform is used to end-end provision the cloud infrastructure dependencies and the Kubernetes cluster in a single operation:

#### OCI Infrastructure

 - Creates VCN with associated:
   - Internet Gateway
   - Route Table
   - Subnets (for LB & Worker Nodes)
   - Security Lists

#### Cluster Configuration

 - Creates OKE Kubernetes cluster:
   - Multiple master nodes (HA control plane)
   - Kubernetes Dashboard
   - Tiller ([Helm](https://helm.sh/) software distribution server-side component)

 - Creates OKE Worker Node Pool:
   - One or many worker nodes
   - Worker Nodes distributed across one or many subnets
   - Subnets distributed across one or many Availability Domains

 - Creates Kubeconfig:
   - Authentication artefact for use by ['kubectl'][kubectl] CLI for cluster administration.

## Prerequisites

1. [Oracle Cloud Infrastructure][oci] Tenancy. If not already subscribed, create your free trial [here][oci-signup].
2. Within your tenancy, a suitably pre-configured compartment must already exist.
3. Within the root compartment of your tenancy, a policy statement (`allow service OKE to manage all-resources in tenancy`) must be defined to give Container Engine for Kubernetes access to resources in the tenancy. See [create policy for Container Engine for Kubernetes](https://docs.cloud.oracle.com/iaas/Content/ContEng/Concepts/contengpolicyconfig.htm#PolicyPrerequisitesService) for guidance.
4. To create and/or manage clusters, you must belong to one of the following:
   - The tenancy's Administrators group.
   - A group to which a policy grants the appropriate Container Engine for Kubernetes permissions. If you are creating or modifying clusters using the Console, policies must also grant the group the Networking permissions VCN_READ and SUBNET_READ. See Create One or More Policies for Groups (Optional).
   - _You (and the groups to which you belong) must have been defined solely in Oracle Cloud Infrastructure Identity and Access Management. Container Engine for Kubernetes does not currently support groups and users for tenancies federated with other identity providers._
5. Download and install [Terraform][terraform] (v0.11.3 or later). Follow the link for [Hashicorp instructions](https://www.terraform.io/intro/getting-started/install.html).
6. [Terraform OCI Provider][oci-provider] (can be pulled automatically using `terraform init` directive once Terraform is configured).

### Configuring the installer

Populate the `terraform.tfvars` file with the folowing information:

1. Environment:
   - Variables `e000_envName` & `e001_envNumber` will be concatenated and used to form the friendly name of various outputs, such as the cluster and node pool.
2. Geography:
   - Nominate the OCI Region, Tenancy, & Compartment that will receive the cluster installation.
3. Credentials:
   - See the following [instruction](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm) for key and fingerprint creation.
   - Variables `c003_rsaPrivateKeyPath` & `c004_rsaPublicKeyPath` are used to specify key pair providing SSH access to worker nodes.
4. OKE:
   - Variable `k009_kubeVers` determines the version of the cluster to be deployed, e.g. `1.8.11`, `v1.9.7`, `v1.10.3`, or `v1.11.1`.
   - Variable `k007_wkrNodeShape` determines the compute shape used for worker nodes, e.g. `VM.Standard1.2`.
   - Variable `k001_quantityWkrSubnets` determines the number of subnets utilised for hosting worker nodes. Valid values are `1`, `2`, or `3`. Where a value greater than 1 is specified, each of the subnets will be provisioned to a separate Availability Domain (Data Center). This provides for a distributed, HA arrangement for node distribution.
   - Variable `k002_quantityPerSubnet` determines the number of worker nodes that will be deployed to each of the subnets specified in `k001_quantityWkrSubnets`.

## Quick start
Once your `terraform.tfvars` file is configured per the above section - proceed to perform the following.

### Deploy the cluster

Initialize Terraform:

```
$ terraform init
```

View what Terraform plans do before actually doing it:

```
$ terraform plan
```

Use Terraform to provision resources and stand-up your OKE cluster on OCI:

```
$ terraform apply
```

The entire build and cluster creation process is automated – no further input is required.

### Output
Once the Terraform apply operation is complete, the `kubeconfig` data will be returned as an output to the console. The `kubeconfig` data contains authentication and cluster connection information. It should be saved to a file & used with the kubectl command-line utility to access and configure the cluster.

### Access the cluster

The Kubernetes cluster will be running after the apply operation completes. Typically, this takes between ~10-15 minutes.

#### Cluster Operations via CLI

To operate the cluster using the `kubectl` CLI, first ensure its installed per this [configuration guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/). You can then submit requests to the OKE kube-api by invoking kubectl and specifying the path to the kubeconfig file:

```
$ kubectl cluster-info --kubeconfig=\path-to-kubeconfig
```

#### Cluster Operations via Dashboard

To access the Kubernetes dashboard, ensure that you have kubectl installed & run the following command:

```
$ kubectl proxy --kubeconfig=\path-to-oke-kubeconfig
```

Open a web browser and request the following URL:
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

The kube dashboard will request authentication method - select kubeconfig as the authentication method, & point to the local kubeconfig file.
