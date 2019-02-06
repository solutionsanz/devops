[atlas]: https://en.wikipedia.org/wiki/Atlas_(mythology)
[examples]:https://github.com/terraform-providers/terraform-provider-oci/tree/master/docs/examples
[cidrsubnet]:http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/
[instructions]: ./docs/instructions.md
[networks]:https://erikberg.com/notes/networks.html
[oci]: https://cloud.oracle.com/cloud-infrastructure
[terraform]: https://www.terraform.io
[terraform options]: ./docs/terraformoptions.md
[terraformvars]:./terraform.tfvars.example


# ociatlas for [Oracle Cloud Infrastructure][oci]

## About

This [Terraform][terraform] module provisions a VCN, Internet Gateway, subnets and security lists for compute hosts and optionally a NAT gateway. It is meant to be a reusable module that other projects can build upon or to quickly set up an environment where you can then manually add other services.

The name **ociatlas** is derived from [Atlas][atlas], a Titan in Greek mythology, condemned to hold the celestial heavens and who had many children. It is an apt name for a project which:

- intends to support cloud-based deployment on OCI
- other OCI-based projects can base their foundation upon   

# Features

- Configurable subnet masks and sizes. This helps you:
    - limit your blast radius
    - avoid the overlapping subnet problem, especially if you need to make a hybrid deployment
    - plan your scalability, HA and failover capabilities
- Optional pre-configured public compute instances across all 3 ADs. The compute instances has the following configurable features:
    - oci-cli installed, optionally upgraded and pre-configured
    - convenient output of how to access the compute instances
    - choice of AD location for the compute instance(s) to avoid problems with service limits/shapes, particularly when using trial accounts

## Pre-reqs

1. Download and install [Terraform][terraform] (v0.11+).
2. [Configure your OCI account to use Terraform](https://docs.cloud.oracle.com/iaas/Content/API/SDKDocs/terraformgetstarted.htm?tocpath=Developer%20Tools%20%7CTerraform%20Provider%7C_____1)

Detailed instructions can be found [here][instructions].

## Environment variables

Ensure you set proxy environment variables if you're running behind a proxy

```
$ export http_proxy=http://<address_of_your_proxy>.com:80/
$ export https_proxy=http://<address_of_your_proxy>:80/
$ export TF_VAR_private_key=$(cat ~/.ssh/id_rsa.pem)
$ export TF_VAR_public_key=$(cat ~/.ssh/id_rsa.pub)
```
Detailed instructions can be found [here][instructions].

## Quickstart

```
$ git clone <repo_url>
$ cp terraform.tfvars.example terraform.tfvars
```
* Set mandatory variables tenancy_ocid, user_ocid, compartment_ocid, fingerprint in terraform.tfvars

* Override other variables vcn_name, vcn_dns_name, shapes etc in terraform.tfvars. See the [terraform.tfvars.example][terraformvars].

Detailed instructions can be found [here][instructions].

### Deploy ociatlas

Initialize Terraform:
```
$ terraform init
```

View what Terraform plans do before actually doing it:

```
$ terraform plan
```

Create the ociatlas:

```
$ terraform apply
```

See [Terraform Configuration Options][terraform options] and [Detailed Instructions][instructions]

## Related Docs

- [Networks, Subnets and CIDR][networks]
- [Terraform cidrsubnet Deconstructed][cidrsubnet]

## Acknowledgement
- Code derived and adapted from [Terraform Provider OCI Examples][examples]

- Folks who contributed with code, feedback, ideas, testing etc:
    - Stephen Cross
    - Cameron Senese
    - Jang Whan
    - Craig Carl

