#!/bin/bash

set -e
set -o pipefail

if ! helm repo list | grep -q "kyverno"; then
  helm repo add kyverno https://kyverno.github.io/kyverno/
fi

helm repo add kyverno https://kyverno.github.io/kyverno/

if ! kubectl get ns | grep -q "kyverno"; then
    helm install kyverno kyverno/kyverno -n kyverno --create-namespace \
    --set admissionController.replicas=3 \
    --set backgroundController.replicas=2 \
    --set cleanupController.replicas=2 \
    --set reportsController.replicas=2 \
    --set validationFailureAction=Audit \
    --set metrics.enabled=true \
    --set autoUpdate.enabled=true \
    --set metrics.serviceMonitor.enabled=true \
    --set metrics.serviceMonitor.labels.release=prometheus-stack
fi

