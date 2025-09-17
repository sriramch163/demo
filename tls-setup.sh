#!/bin/bash
# TLS Setup Script - Automatic Certificate Generation

# Install cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

# Wait for cert-manager to be ready
kubectl wait --for=condition=ready pod -l app=cert-manager -n cert-manager --timeout=300s

# Install NGINX Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# Wait for ingress controller
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=ingress-nginx -n ingress-nginx --timeout=300s

# Apply TLS configuration
kubectl apply -f cert-manager-issuer.yaml
kubectl apply -f wisecow-ingress.yaml

echo "TLS setup complete. Update domain in wisecow-ingress.yaml and email in cert-manager-issuer.yaml"