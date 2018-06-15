#!/bin/bash

#######################################################################
# Deploy Cloud native Technologies into curated Kubernetes cluster.
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
# Based on Cameron Senese's scripts: https://github.com/cameronsenese/opc-terraform-kubernetes-installer
#######################################################################


#####################################
############# For more info: https://docs.bitnami.com/oracle/how-to/generate-install-lets-encrypt-ssl/

DOMAIN="apip.oracleau.cloud"
EMAIL="carlos.rodriguez.iturria@oracle.com"

sudo /opt/bitnami/ctlscript.sh stop
sudo /usr/local/bin/lego --email="${EMAIL}" --domains="${DOMAIN}" --path="/etc/lego" renew
sudo /opt/bitnami/ctlscript.sh start