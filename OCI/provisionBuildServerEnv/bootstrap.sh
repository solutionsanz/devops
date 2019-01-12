    echo "##########################################################################"
    echo "###################### Updating packages ##############################"

    sudo apt-get update

    echo "##########################################################################"    
    echo "###################### Installing Git ##############################"

    sudo apt-get install git -y
   
    echo "##########################################################################"
    echo "############### Installing NodeJS on an Ubuntu Machine ###############"

    sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

    sudo apt-get install nodejs -y

    echo "##########################################################################"
    echo "############# Installing and configuring Docker for Dev #######################"

    sudo apt-get install docker.io -y
    sudo usermod -G docker ubuntu    
    docker --version

    echo "##########################################################################"
    echo "############# Installing and configuring Terraform #######################"

    mkdir /home/vagrant/terraform && cd /home/vagrant/terraform
    wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
	sudo apt-get install unzip -y && sudo unzip /home/vagrant/terraform/terraform_*.zip -d /usr/local/bin
	terraform --version
	cd /vagrant && terraform init    

