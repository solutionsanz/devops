#!/bin/bash
# Build Kubernetes based on the Oracle Linux Container Services for use with Kubernetes.
# The current release of Oracle Linux Container Services for use with Kubernetes is based on Kubernetes
# version 1.8.4, as released upstream.
#
# Note: Initial version created by: cameron.senese@oracle.com

logger *** TF Remote-Exec Started ***
  echo "MGT :: Remote-Exec :: Let's get started ..."
  #variables..
  TIMEOUT="250"
  #functions..
    #evaluate pod status..
    function kubectl::get_pod {
        local counter=0
        local status=""
          #echo "In-func waiting on: " $1 " to be up and running.."
            for ((counter=0; counter < ${TIMEOUT}; counter++)); do
                    status=$(kubectl --kubeconfig=${KUBECONFIG} get pod -n $1 | awk '{print $3}' | sort -u | head -n1)
                    if [ "${status}" = "Running" ]; then
                            echo "All" $1 "pods running ..."
                            break
                    else
                            sleep 5
                    fi
            done
    }
    #let's get going..
    echo "MGT :: Remote-Exec :: Configuaration files ..."
        cp /tmp/mgt/public-yum-ol7.repo /etc/yum.repos.d/
    echo "MGT :: Remote-Exec :: Configuaration files ... :: Done ..."

    echo "MGT :: Remote-Exec :: Configuring firewall & routing ..."
        sysctl -w net.ipv4.ip_forward=1
        modprobe br_netfilter
        echo "br_netfilter" > /etc/modules-load.d/br_netfilter.conf
    echo "MGT :: Remote-Exec :: Configuring firewall & routing ... :: Done ..."

    echo "MGT :: Remote-Exec :: Install Utils ..."
        chmod +x /tmp/mgt/env/*.sh
        /tmp/mgt/env/envUtils.sh >>/tmp/noise.out
    echo "MGT :: Remote-Exec :: Install Utils ... :: Done ..."

    echo "MGT :: Remote-Exec :: Install Docker ..."
        yum install docker-engine -y >>/tmp/noise.out
        systemctl enable docker >>/tmp/noise.out
        systemctl start docker >>/tmp/noise.out
    echo "MGT :: Remote-Exec :: Install Docker ... :: Done ..."

    echo "MGT :: Remote-Exec :: Install K8s ..."
        #setup kubeadm and install script..
        yum install kubeadm-1.8.4-2.0.1.el7 kubelet-1.8.4-2.0.1.el7 kubectl-1.8.4-2.0.1.el7 -y >>/tmp/noise.out
        docker login container-registry.oracle.com -u$1 -p$2 >/dev/null
        docker pull busybox >/dev/null

        docker pull container-registry.oracle.com/kubernetes/pause-amd64:3.0
        docker pull container-registry.oracle.com/kubernetes/kube-proxy-amd64:v1.8.4
        docker pull container-registry.oracle.com/kubernetes/flannel:v0.9.0-amd64
        docker pull container-registry.oracle.com/kubernetes/k8s-dns-kube-dns-amd64:1.14.5
        docker pull container-registry.oracle.com/kubernetes/kube-controller-manager-amd64:v1.8.4
        docker pull container-registry.oracle.com/kubernetes/kube-scheduler-amd64:v1.8.4
        docker pull container-registry.oracle.com/kubernetes/kube-apiserver-amd64:v1.8.4
        docker pull container-registry.oracle.com/kubernetes/k8s-dns-sidecar-amd64:1.14.5
        docker pull container-registry.oracle.com/kubernetes/k8s-dns-dnsmasq-nanny-amd64:1.14.5
        docker pull container-registry.oracle.com/kubernetes/etcd-amd64:3.0.17
        docker pull container-registry.oracle.com/kubernetes/kubernetes-dashboard-amd64:v1.7.0

        #docker pull container-registry.oracle.com/kubernetes/pause-amd64:3.0 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/kube-proxy-amd64:v1.8.4 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/flannel:v0.9.0-amd64 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/k8s-dns-kube-dns-amd64:1.14.5 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/kube-controller-manager-amd64:v1.8.4 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/kube-scheduler-amd64:v1.8.4 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/kube-apiserver-amd64:v1.8.4 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/k8s-dns-sidecar-amd64:1.14.5 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/k8s-dns-dnsmasq-nanny-amd64:1.14.5 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/etcd-amd64:3.0.17 >/dev/null &
        #docker pull container-registry.oracle.com/kubernetes/kubernetes-dashboard-amd64:v1.7.0 >/dev/null &
        #install k8s..
        cp /tmp/mgt/kubeadm-setup.sh /usr/bin
        cp /tmp/mgt/kubernetes-dashboard-ol.yaml /usr/local/share/kubeadm
        chmod +x /usr/bin/kubeadm-setup.sh
        kubeadm-setup.sh up --pod-network-cidr 10.100.0.0/16
        #setup root k8s shell environment..
        cp /etc/kubernetes/admin.conf $HOME/
        chown $(id -u):$(id -g) $HOME/admin.conf
        export KUBECONFIG=$HOME/admin.conf
        echo 'export KUBECONFIG=$HOME/admin.conf' >> $HOME/.bashrc
    echo "MGT :: Remote-Exec :: Install K8S ... :: Done ..."

    echo "MGT :: Remote-Exec :: Configure K8s ..."
        #untaint master..
        kubectl taint nodes --all node-role.kubernetes.io/master- >>/tmp/noise.out
        echo "Waiting for kube-system pods to be up and running ..."
        kubectl::get_pod kube-system
        echo "Configuring K8s dashboard ..."
        #k8s dashboard..
        kubectl create -f /tmp/mgt/kubernetes-dashboard-rbac.yaml >>/tmp/noise.out
        echo "Waiting for kube-system pods (dasboard & dependencies) to be up and running ..."
        kubectl::get_pod kube-system
    echo "MGT :: Remote-Exec :: Configure K8S ... :: Done ..."

    echo "MGT :: Remote-Exec :: Configure Environments ..."
        #dashboard, monitoring, & metrics..
            if [ $3 = "true" ]; then
                echo "ENV-1 :: Updating K8s Dashboard, Monitoring & Metrics ..."
                /tmp/mgt/env/envDashMonMet.sh
            echo "Waiting for kube-system pods (dasboard & dependencies) to be up and running ..."
            kubectl::get_pod kube-system
            fi
        #microservices..
            if [ $5 = "true" ]; then
                echo "ENV-2 :: Installing Microservices Environment ..."
                /tmp/mgt/env/envMicroSvc.sh
            echo "Waiting for sock-shop pods (microservices application) to be up and running ..."
            kubectl::get_pod sock-shop
            fi
        #ingress controller..
            if [ $6 = "true" ]; then
                echo "ENV-3 :: Installing Traefik Ingress Controller ..."
                /tmp/mgt/env/envIngress.sh
            echo "Waiting for kube-system pods to be up and running ..."
            kubectl::get_pod kube-system
            fi
        #fn..
            if [ $4 = "true" ]; then
                echo "ENV-4 :: Installing Fn ..."
                /tmp/mgt/env/envFn.sh
            echo "Waiting for default pods to be up and running ..."
            kubectl::get_pod default
            fi
        #service mesh..
            if [ $7 = "true" ]; then
                echo "ENV-5 :: Installing Service Mesh Control Plane ..."
                /tmp/mgt/env/envSvcMesh.sh
            echo "Waiting for istio-system & default pods to be up and running ..."
            kubectl::get_pod istio-system
            kubectl::get_pod default
            fi
    echo "MGT :: Remote-Exec :: Configure Environments ... :: Done ..."

    echo " "
    echo "MGT :: Remote-Exec :: List all services ..."
    echo "----------------------------------------------------------------------------------------"
    kubectl get services --all-namespaces
    echo " "
    echo "MGT :: Remote-Exec :: List all pods ..."
    echo "----------------------------------------------------------------------------------------"
    kubectl get pods --all-namespaces

  echo " "
  echo "MGT :: Remote-Exec :: Done ..."
logger *** TF Remote-Exec Stopped ***
