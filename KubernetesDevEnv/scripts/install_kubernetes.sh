    echo "##########################################################################"
    echo "############### Installing Kubernetes on an Ubuntu Machine ###############"

    echo "###################### Updating packages ##############################"

    sudo apt-get update

    echo "##########################################################################"
    echo "###################### Installing Git ##############################"

    sudo apt-get install git -y
   
    echo "##########################################################################"
    echo "###################### Installing Kubectl ##############################"

    wget https://storage.googleapis.com/kubernetes-release/release/v1.10.1/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    sudo mv kubectl /usr/local/bin/ 
    kubectl version

    
    echo "##########################################################################"
    echo "###################### Installing Minikube for Dev #######################"
	 
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.26.0/minikube-linux-amd64 && \
    chmod +x minikube && \
    sudo mv minikube /usr/local/bin/ 
    minikube version


    echo "##########################################################################"
    echo "############# Installing and configuring Docker for Dev #######################"

    sudo apt-get install docker.io -y
    sudo usermod -G docker ubuntu    
    docker --version

    echo "########################################################################"
