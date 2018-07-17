    echo "###########################################################################"
    echo "######################### Initiating Bootstrap ############################"
    
    echo "##########################################################################"
    echo "######################### Adding swapfile ##############################"

    #See: https://www.centos.org/docs/5/html/5.2/Deployment_Guide/s2-swap-creating-file.html

    sudo free

    sudo dd if=/dev/zero of=/swapfile bs=1024 count=716800

    sudo mkswap /swapfile

    sudo swapon /swapfile

    #Edit:  /etc/fstab
    #    Add:
    #        /swapfile swap swap defaults 0 0

    sudo echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

    sudo free


    echo "###########################################################################"
    echo "########################## Done with Bootstrap ############################"
    echo "###########################################################################"
