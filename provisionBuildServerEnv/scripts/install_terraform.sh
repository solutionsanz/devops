sudo apt-get update
echo "************************ Setting up Environment for Terraform"
echo "****************** Installing Terraform"
sudo curl -X GET https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip -o terraform_0.11.3_linux_amd64.zip
sudo apt-get install unzip -y
sudo unzip terraform_*.zip -d /usr/local/bin
terraform --version
