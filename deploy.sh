#!/bin/bash

# Create TLS secret from existing certificates
kubectl create secret tls wisecow-tls --cert=tls/tls.crt --key=tls/tls.key --dry-run=client -o yaml | kubectl apply -f -

# Deploy all Kubernetes manifests
kubectl apply -f k8s/

# Wait for deployment to be ready
kubectl rollout status deployment/wisecow-deployment

echo "Deployment complete! Access at https://wisecow.local"
echo "Add '127.0.0.1 wisecow.local' to your /etc/hosts file"