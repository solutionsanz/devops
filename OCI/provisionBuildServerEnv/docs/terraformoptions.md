# Terraform Configuration options

[cidrsubnet]:http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/
[networks]:https://erikberg.com/notes/networks.html
[terraform example]: ../terraform.tfvars.example

## Basic OCI Configurations
| Option                                | Description                                   | Values                    | Default               | 
| -----------------------------------   | -------------------------------------------   | ------------              | -------------------   |
| tenancy_ocid                          | OCI tenancy ocid (required)                   |                           |  None                 |
| user_ocid                             | OCI user ocid (required)                      |                           |  None                 |
| compartment_ocid                      | OCI compartment ocid (required)               |                           |  None                 |                    
| fingerprint                           | ssh fingerprint (required)                    |                           |  None                 |     
| region                                | OCI region where to provision (required)      | eu-frankfurt-1, us-ashburn-1, uk-london-1, us-phoenix-1 | us-ashburn-1 |
| vcn_dns_name                          | VCN's DNS name                                |                           |  devoci               |
| vcn_cidr                              | VCN's CIDR                                    |                           | 10.0.0.0/16           |
| vcn_name                              | VCN's name in the OCI Console                 |                           |  ocivcn              |
| newbits                               | The difference between the VCN's netmask and the desired subnets mask. At the moment, it is the same value for every subnets. In future, this will be improved so that individual subnets can have their own newbits value. This translates into the newbits parameter in the cidrsubnet Terraform function. [In-depth explanation][cidrsubnet]. Related [networks, subnets and cidr][networks] documentation.                                              |               |   8        |
| subnets                               | Defines the boundaries of the subnets. This translates into the netnum parameter in the cidrsubnet Terraform function. [In-depth explanation][cidrsubnet]. Related [networks, subnets and cidr][networks] documentation.                                            | See [terraform.tfvars.example][terraform example]                |    See [terraform.tfvars.example][terraform example]        |
| imageocids                            | The ocids of the images to use for the bastion instances. Tested with Oracle Linux 7.x. Should work with Oracle Linux 6.x and CentOS 6.x and 7.x too       |               |  See [terraform.tfvars.example][terraform example]              |
| label_prefix                          | A prefix that's prepended to created resources  |        |  dev             |

## Bastion Options
| Option                                | Description                                   | Values                    | Default               | 
| -----------------------------------   | -------------------------------------------   | ------------              | -------------------   |
| bastion_shape                         | The shape of the bastion instance that will be provisioned.  |               | VM.Standard2.2          |
| availability_domains                                    | Where to provision bastion instances and other resources.  |    | See [terraform.tfvars.example][terraform example]    |
| bastion_timezone                      | Which timezone to configure on the bastions    |               | Australia/Sydney          | 
| update_bastion                        | Whether to update the bastion instances        |  true/false   | false          | 

## NAT Gateway Options
| Option                                | Description                                   | Values                    | Default               | 
| -----------------------------------   | -------------------------------------------   | ------------              | -------------------   |
| create_nat_gateway                    | Whether to create a NAT gateway               |  true/false               | false                 || nat_gateway_name                      | The name of the NAT gateway                   |                           | nat                   | 