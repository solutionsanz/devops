#!/bin/bash
#
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

# variables
REGISTRY=container-registry.oracle.com/kubernetes
K8S_VERSION=1.8.4
DNS_VERSION=1.14.5
FLANNEL_VERSION=v0.9.0
DASHBOARD_VERSION=v1.7.1
ETCD_VERSION=3.0.17
PAUSE_VERSION=3.0

function ops {
  local ops="${1:-}"
  local registry="${2:-${REGISTRY}}"

  docker ${ops} ${registry}/flannel:${FLANNEL_VERSION}-amd64
  docker ${ops} ${registry}/etcd-amd64:${ETCD_VERSION}
  docker ${ops} ${registry}/pause-amd64:${PAUSE_VERSION}
  docker ${ops} ${registry}/kube-controller-manager-amd64:${K8S_VERSION}
  docker ${ops} ${registry}/kube-scheduler-amd64:${K8S_VERSION}
  docker ${ops} ${registry}/kube-apiserver-amd64:${K8S_VERSION}
  docker ${ops} ${registry}/kube-proxy-amd64:${K8S_VERSION}
  docker ${ops} ${registry}/k8s-dns-sidecar-amd64:${DNS_VERSION}
  docker ${ops} ${registry}/k8s-dns-kube-dns-amd64:${DNS_VERSION}
  docker ${ops} ${registry}/k8s-dns-dnsmasq-nanny-amd64:${DNS_VERSION}
  docker ${ops} ${registry}/kubernetes-dashboard-amd64:${DASHBOARD_VERSION}
  docker ${ops} ${registry}/kubernetes-dashboard-init-amd64:v1.0.0
}

function tag {
  local from="${1:-${REGISTRY}}"
  local to="${2:-}"

  docker tag ${from}/flannel:${FLANNEL_VERSION}-amd64 ${to}/flannel:${FLANNEL_VERSION}-amd64
  docker tag ${from}/etcd-amd64:${ETCD_VERSION} ${to}/etcd-amd64:${ETCD_VERSION}
  docker tag ${from}/pause-amd64:${PAUSE_VERSION} ${to}/pause-amd64:${PAUSE_VERSION}
  docker tag ${from}/kube-controller-manager-amd64:${K8S_VERSION} ${to}/kube-controller-manager-amd64:${K8S_VERSION}
  docker tag ${from}/kube-scheduler-amd64:${K8S_VERSION} ${to}/kube-scheduler-amd64:${K8S_VERSION}
  docker tag ${from}/kube-apiserver-amd64:${K8S_VERSION} ${to}/kube-apiserver-amd64:${K8S_VERSION}
  docker tag ${from}/kube-proxy-amd64:${K8S_VERSION} ${to}/kube-proxy-amd64:${K8S_VERSION}
  docker tag ${from}/k8s-dns-sidecar-amd64:${DNS_VERSION} ${to}/k8s-dns-sidecar-amd64:${DNS_VERSION}
  docker tag ${from}/k8s-dns-kube-dns-amd64:${DNS_VERSION} ${to}/k8s-dns-kube-dns-amd64:${DNS_VERSION}
  docker tag ${from}/k8s-dns-dnsmasq-nanny-amd64:${DNS_VERSION} ${to}/k8s-dns-dnsmasq-nanny-amd64:${DNS_VERSION}
  docker tag ${from}/kubernetes-dashboard-amd64:${DASHBOARD_VERSION} ${to}/kubernetes-dashboard-amd64:${DASHBOARD_VERSION}
  docker tag ${from}/kubernetes-dashboard-init-amd64:v1.0.0 ${to}/kubernetes-dashboard-init-amd64:v1.0.0
}

function check {
  local from="${1:-${REGISTRY}}"
  local to="${2:-}"
  local version="${3:-}"
  local image="pause-amd64"

  # start docker-engine
  echo "Checking if docker is active ..."
  if ! systemctl -q is-active docker; then
        echo "[ERROR] docker is not started ... please start docker"
        exit 1
  fi

  if [ "${version}" = "1.7.4" ]; then
        K8S_VERSION=v${version}
        DNS_VERSION=1.14.4
        FLANNEL_VERSION=v0.7.1
        ETCD_VERSION=3.0.17
        PAUSE_VERSION=3.0
        DASHBOARD_VERSION=v1.7.0
  elif [ "${version}" = "1.8.4" ]; then
        K8S_VERSION=v${version}
        DNS_VERSION=1.14.5
        FLANNEL_VERSION=v0.9.0
        ETCD_VERSION=3.0.17
        PAUSE_VERSION=3.0
        DASHBOARD_VERSION=v1.7.0
  else
        echo "[ERROR] ${version} is not a valid version"
        exit 1
  fi

  echo "Checking for pull access from ${from} registry ..."
  local result=$(echo ""|docker pull ${from}/${image}:${PAUSE_VERSION} 2>&1|grep "Please login")
  if [ -n "${result}" ]; then
        echo "[ERROR] Please login with valid credential to the ${from}"
        echo "        # docker login ${from}"
        exit 1
  else
        if ! docker pull ${from}/${image}:${PAUSE_VERSION}; then
                echo "[ERROR] docker cannot pull ${image}:${PAUSE_VERSION} from ${from} registry"
                exit 1
        fi
  fi

  docker tag ${from}/${image}:${PAUSE_VERSION} ${to}/${image}:${PAUSE_VERSION}

  echo "Checking for push access to ${to} registry ..."
  if ! docker push ${to}/${image}:${PAUSE_VERSION}; then
	echo "[ERROR] docker cannot push ${image}:${PAUSE_VERSION} to ${to} registry"
	exit 1
  fi
}

function usage {
	echo "This script is to help pulling docker images from default container-registry.oracle.com to a local repo" >&2
	echo "usage: " >&2
	echo "  $0 --to registry [--from registry --version ${K8S_VERSION}]" >&2
	exit 1
}

# MAIN
ARG=($@)
PASS="0"
VERSION="${K8S_VERSION}"
FROM="${REGISTRY}"
for((i=0; i<$#; i++)); do
	if [ "${ARG[${i}]}" = "--to" ]; then
		PASS="1"
		i=$((i+1))
		TO="${ARG[${i}]:-}"
		if [ -z "${TO}" ]; then
			echo "[ERROR] Please provide a valid local registry location"
			exit 1
		fi
	elif [ "${ARG[${i}]}" = "--from" ]; then
		i=$((i+1))
		FROM="${ARG[${i}]:-${REGISTRY}}"
	elif [ "${ARG[${i}]}" = "--version" ]; then
		i=$((i+1))
		VERSION="${ARG[${i}]:-"${K8S_VERSION}"}"
	else
		usage
	fi
done

if [ "${PASS}" != "1" ]; then
	usage
fi

echo "Pulling images [${VERSION}] from: [${FROM}] to: [${TO}]"
check "${FROM}" "${TO}" "${VERSION}"
ops "pull" "${FROM}" # pull from registry
tag "${FROM}" "${TO}"
ops "push" "${TO}" # push to registry
echo "[SUCCESS] All images pushed to [${TO}]"
