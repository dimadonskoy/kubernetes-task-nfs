#!/usr/bin/env bash
#######################################################################
# Developed by : Dmitri Donskoy
# Purpose : Create Kubernetes resources
# Date : 22.07.2025
# Version : 0.0.1
# set -x
set -o errexit
set -o nounset
set -o pipefail
#######################################################################

NAMESPACE="webapp"

### Create namespace if not exists ###
if ! kubectl get ns "$NAMESPACE" &> /dev/null; then
    kubectl create ns "$NAMESPACE"
else
    echo "Namespace $NAMESPACE already exists."
fi

### Apply PV ###
kubectl apply -f files/webapp_pv.yaml

### Apply PVC  ###
kubectl apply -f files/webapp_pvc.yaml -n "$NAMESPACE"

### Apply ConfigMap ###
kubectl apply -f files/webapp_configmap.yaml -n "$NAMESPACE"

### Apply Deployment ###
kubectl apply -f files/webapp_deployment.yaml -n "$NAMESPACE"

### Apply Service ###
kubectl apply -f files/webapp_service.yaml -n "$NAMESPACE"
