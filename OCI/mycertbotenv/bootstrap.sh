    echo "##########################################################################"
    echo "###################### Updating packages ##############################"

    sudo apt-get update

    echo "##########################################################################"    
    echo "###################### Installing Git and Zip ##############################"

    sudo apt-get install git -y
    sudo apt-get install zip -y
   
    echo "##########################################################################"    
    echo "################## Installing GiLets encrypt certbot########################"

    # For more information see: https://redthunder.blog/2018/11/28/how-to-generate-wildcard-ssl-certificates-for-your-lbaas/

    sudo apt-get install python-minimal -y

    python -–version

    mkdir /home/vagrant/mycerts && cd /home/vagrant/mycerts

    git clone https://github.com/certbot/certbot.git

    