DevOps
------

This repository contains multiple recipes to automate infrastructure as code and software continuous delivery 

Using Terraform to provision a new Ubuntu 16.04 VM on OCI classic:
------

   - Ensure you have installed Vagrant on your laptop/PC. If you need help, [read this blog](https://redthunder.blog/2018/02/13/teaching-how-to-use-vagrant-to-simplify-building-local-dev-and-test-environments/). 

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - In a terminal window, go to where you cloned/downloaded the repository (devops/usingTerraform) – Notice that the Vagrantfile is already in there.

    - Start up your Vagrant Dev VM:

	        vagrant up

   - Voila! Your environment with Terraform is ready to go! You can now **vagrant ssh** into it and start reviewing your Terraform Plan (**terraform plan**) and Apply it (**terraform apply**). Read [this blog](https://redthunder.blog/2018/02/20/teaching-how-to-use-terraform-to-manage-oracle-cloud-infrastructure-as-code/) for step by step instructions how to use it.


Using PaaS Service Manager (PSM) CLI on a local Vagrant Ubuntu 16.04 box:
------

   - Ensure you have installed Vagrant on your laptop/PC. If you need help, [read this blog](https://redthunder.blog/2018/02/13/teaching-how-to-use-vagrant-to-simplify-building-local-dev-and-test-environments/). 

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - In a terminal window, go to where you cloned/downloaded the repository (devops/usingPSM_CLI) – Notice that the Vagrantfile is already in there.

    - Start up your Vagrant Dev VM:

	        vagrant up

   - Voila! Your environment with PSM CLI is ready to go! You can now **vagrant ssh** into it and setup PSM CLI to point to your Oracle Cloud environment. Read [this blog](https://redthunder.blog/2018/03/07/teaching-how-to-use-oracle-paas-service-manager-psm-cli-to-provision-oracle-paas-environments/) for step by step instructions how to use it.

Using Terraform to provision a new Ubuntu 16.04 based Build Server on OCI classic:
------

   - Ensure you have installed Vagrant on your laptop/PC. If you need help, [read this blog](https://redthunder.blog/2018/02/13/teaching-how-to-use-vagrant-to-simplify-building-local-dev-and-test-environments/). 

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - In a terminal window, go to where you cloned/downloaded the repository (devops/provisionAPIGWEnv) – Notice that the Vagrantfile is already in there.

    - Start up your Vagrant Dev VM:

	        vagrant up

   - Voila! Your environment with Terraform is ready to go! You can now **vagrant ssh** into it and start reviewing your Terraform Plan (**terraform plan**) and Apply it (**terraform apply**). Read [this blog](https://redthunder.blog/2018/02/20/teaching-how-to-use-terraform-to-manage-oracle-cloud-infrastructure-as-code/) for step by step instructions how to use it.

Installing Kubernetes locally or in the Oracle Public Cloud:
------

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - Read [this blog](https://redthunder.blog/2018/04/18/teaching-how-to-quickly-provision-a-dev-kubernetes-environment-locally-or-in-oracle-cloud/) for step by step instructions how to use it.

Provisioning Oracle Integration Cloud (PaaS):
------

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - Read [this blog](https://redthunder.blog/2018/03/28/teaching-how-to-use-terraform-to-automate-provisioning-of-oracle-integration-cloud-oic/) for step by step instructions how to use it.

Provisioning Oracle API Platform (PaaS):
------

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - Read [this blog](https://redthunder.blog/2018/03/29/teaching-how-to-use-terraform-to-automate-provisioning-of-oracle-api-platform/) for step by step instructions how to use it.


Provisioning a MongoDB Env on Oracle Public Cloud:
------

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - Create an ssh folder and set your public key (myPublic_sshKey.pub) and set your terraform.tfvars configuration properties. Read [this blog](https://redthunder.blog/2018/03/29/teaching-how-to-use-terraform-to-automate-provisioning-of-oracle-api-platform/) as a guideline on the steps that need to be followed.


Provisioning a CiviCRM Env on Oracle Public Cloud:
------

   - Download or Git clone this Github repo: 

			git clone https://github.com/solutionsanz/devops

   - Create an ssh folder and set your public key (myPublic_sshKey.pub) and set your terraform.tfvars configuration properties. Read [this blog](https://redthunder.blog/2018/03/29/teaching-how-to-use-terraform-to-automate-provisioning-of-oracle-api-platform/) as a guideline on the steps that need to be followed.