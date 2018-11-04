#!/bin/sh
set -e

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

helm init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy --patch '{"spec": {"template": {"spec": {"serviceAccount": "tiller"} } } }'

git clone https://github.com/jetstack/cert-manager
cd cert-manager
git checkout v0.2.3 # version of 2018-02-19
helm install \
  --name cert-manager \
  --namespace kube-system \
  contrib/charts/cert-manager