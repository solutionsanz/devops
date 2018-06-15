#######################################################################
# Deploy Cloud native Technologies into curated Kubernetes cluster.
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
# Based on Cameron Senese's scripts: https://github.com/cameronsenese/opc-terraform-kubernetes-installer
#######################################################################
#################### Reading and validating passed parameters:


if [ "$#" -ne 2 ]; then

    echo "**************************************** Error: "
    echo " Illegal number of parameters."
    echo " Mark as true or false for the following components that you wish to deploy"
    echo " Order: [email domain]"
    echo " Example: ./configureSSL.sh joe.mero@email.com lb.mydomain.com"
    echo "****************************************"
    exit 1
    
fi

#####################################
############# For more info: https://docs.bitnami.com/oracle/how-to/generate-install-lets-encrypt-ssl/

DOMAIN=$1
EMAIL=$2

######################################################################
######################################################################
######################################################################
######## Step 1: Install the Lego client:
##### These steps will download, extract and copy the Lego client to a directory in your path.

cd /tmp
curl -s https://api.github.com/repos/xenolf/lego/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4 | wget -i -
tar xf lego_*_linux_amd64.tar.gz
sudo mv lego /usr/local/bin/lego

######################################################################
######################################################################
######################################################################
######## Step 2: Generate a Let's Encrypt certificate for your domain:
##### NOTE: Before proceeding with this step, ensure that your domain name points to the public 
# IP address of the Bitnami application host.

# Turn off all Bitnami services:
sudo /opt/bitnami/ctlscript.sh stop

# Request a new certificate for your domain as below. Remember to replace the DOMAIN placeholder with your 
# actual domain name, and the EMAIL-ADDRESS placeholder with your email address.
##########################
############### SORRY: 1 out of 2 MANUAL INTERVENTION NEEDED (for now) to Agree to the terms of service....
##########################
sudo lego --email="${EMAIL}" --domains="${DOMAIN}" --path="/etc/lego" run

# A set of certificates will now be generated in the /etc/lego/certificates directory. This set includes 
# the server certificate file DOMAIN.crt and the server certificate key file DOMAIN.key.

######################################################################
######################################################################
######################################################################
######## Step 3: Configure the Web server to use the Let's Encrypt certificate on Nginx:
sudo mv /opt/bitnami/nginx/conf/server.crt /opt/bitnami/nginx/conf/server.crt.old
sudo mv /opt/bitnami/nginx/conf/server.key /opt/bitnami/nginx/conf/server.key.old
sudo mv /opt/bitnami/nginx/conf/server.csr /opt/bitnami/nginx/conf/server.csr.old
sudo ln -s /etc/lego/certificates/${DOMAIN}.crt /opt/bitnami/nginx/conf/server.crt
sudo ln -s /etc/lego/certificates/${DOMAIN}.key /opt/bitnami/nginx/conf/server.key
sudo chown root:root /opt/bitnami/nginx/conf/server*
sudo chmod 600 /opt/bitnami/nginx/conf/server*

# Restart all Bitnami services (Nginx, PHP, MySQL):
sudo /opt/bitnami/ctlscript.sh start


######################################################################
######################################################################
######################################################################
######## Step 4: Test the configuration
######## After reconfirming that your domain name points to the public IP address of the Bitnami application 
######## instance, you can test it by browsing to https://DOMAIN (replace the DOMAIN placeholder with the correct domain name).


######################################################################
######################################################################
######################################################################
######## Step 5: Renew the Let's Encrypt certificate
######## Let's Encrypt certificates are only valid for 90 days. To renew the certificate before it expires, run the following 
######## commands from the server console as the bitnami user. Remember to replace the DOMAIN placeholder with your actual 
######## domain name, and the EMAIL-ADDRESS placeholder with your email address.

##########################
############### SORRY: 2 out of 2 MANUAL INTERVENTION NEEDED (for now)....
##########################

# 1. Save renewCert.sh into /etc/lego:  sudo vi /etc/lego/renew-certificate.sh
# 2. Make sure the domain and email is correct.
# 3. Strings it (just in case) and make it executable: sudo sed -i 's/\r//g' /etc/lego/renew-certificate.sh && sudo chmod +x /etc/lego/renew-certificate.sh
# 4. Add cron: 
#               sudo crontab -e
#               0 0 1 * * /etc/lego/renew-certificate.sh 2> /dev/null

###### FYI:
#
#   sudo cp /opt/bitnami/nginx/conf/bitnami/bitnami.conf /opt/bitnami/nginx/conf/bitnami/bitnami.conf_orig
#   sudo vi /opt/bitnami/nginx/conf/bitnami/bitnami.conf
#
#           See full sample within this directory under bitnami.conf_prod_sample:
#
#           Restart with: sudo /opt/bitnami/ctlscript.sh restart ngnix
