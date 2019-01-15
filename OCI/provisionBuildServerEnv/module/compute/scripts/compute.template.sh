#!/bin/bash

systemctl stop postfix.service
systemctl disable postfix.service

systemctl restart firewalld


currOS=`uname -a | grep -v ubuntu`
if [[ $currOS =~ "ubuntu" || $currOS =~ "Ubuntu" ]];
then
    
    \cp -R /root/.oci /home/ubuntu/.oci

    \cp /root/.ssh/oci_rsa.pem /home/ubuntu/.ssh/

    chown -R ubuntu:ubuntu /home/ubuntu/.oci

    chown ubuntu:ubuntu /home/ubuntu/.ssh/oci_rsa.pem

    sed -i "s|/root|/home/ubuntu|" /home/ubuntu/.oci/config


    echo "##########################################################################"
    echo "############# Installing and configuring Terraform #######################"

    mkdir /home/ubuntu/terraform && cd /home/ubuntu/terraform
    wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
	sudo apt-get install unzip -y && sudo unzip /home/ubuntu/terraform/terraform_*.zip -d /usr/local/bin
	terraform --version


else
    \cp -R /root/.oci /home/opc/.oci

    \cp /root/.ssh/oci_rsa.pem /home/opc/.ssh/

    chown -R opc:opc /home/opc/.oci

    chown opc:opc /home/opc/.ssh/oci_rsa.pem

    sed -i "s|/root|/home/opc|" /home/opc/.oci/config
fi