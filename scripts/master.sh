#!/usr/bin/bash
set -eu

# Initialize Cluster
if [[ -n "$FEATURE_GATES" ]]
then
  kubeadm init --pod-network-cidr="$POD_NETWORK_CIDR" --feature-gates "$FEATURE_GATES"
else
  kubeadm init  --pod-network-cidr="$POD_NETWORK_CIDR"
fi
systemctl enable docker kubelet

# used to join nodes to the cluster
kubeadm token create --print-join-command > /tmp/kubeadm_join

mkdir -p "$HOME/.kube"
cp /etc/kubernetes/admin.conf "$HOME/.kube/config"
