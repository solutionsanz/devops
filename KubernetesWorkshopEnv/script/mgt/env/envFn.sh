#!/bin/bash
  TIMEOUT="250"
  #functions..
    #evaluate pod status..
    function kubectl::get_pod {
        local counter=0
        local statusP=""
        local statusC=""
            for ((counter=0; counter < ${TIMEOUT}; counter++)); do
                    statusP=$(kubectl --kubeconfig=${KUBECONFIG} get pod -n $1 | awk '/tiller/ {print $3}')
                    if [ "${statusP}" = "Running" ]; then
                        statusC=$(kubectl --kubeconfig=${KUBECONFIG} get pod -n $1 | awk '/tiller/ {print $2}')
                        if [ "${statusC}" = "1/1" ]; then
                                echo "All" $1 "pods & containers running ..."
                                break
                        else
                            sleep 5
                        fi
                    fi
            done
    }
  #helm..
  kubectl apply -f /tmp/mgt/env/envFn/tiller-rbac.yaml >>/tmp/noise.out                                                            
  chmod +x /tmp/mgt/env/envFn/get_helm.sh >>/tmp/noise.out
  timeout 60 /tmp/mgt/env/envFn/get_helm.sh >>/tmp/noise.out
  sleep 60
  kubectl::get_pod kube-system
  helm init --service-account tiller >>/tmp/noise.out
  helm init --client-only >>/tmp/noise.out
  kubectl::get_pod kube-system
  #fn..
  git clone --quiet https://github.com/fnproject/fn-helm.git && cd fn-helm
  cp /tmp/mgt/env/envFn/values.yaml fn/ >>/tmp/noise.out
  helm dep build fn >>/tmp/noise.out
  helm install --name rel-01 fn >>/tmp/noise.out
  
  export PATH=$PATH:/usr/local/bin/
  echo 'export PATH="$PATH:/usr/local/bin/"' >> $HOME/.bashrc
  