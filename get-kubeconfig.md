# Get Proper Kubeconfig for GitHub Actions

## Generate kubeconfig with embedded certificates:

```bash
# Get kubeconfig with embedded certs (not file paths)
kubectl config view --raw --flatten | base64 -w 0
```

## Or create a service account approach:

```bash
# Create service account
kubectl create serviceaccount github-deploy
kubectl create clusterrolebinding github-deploy --clusterrole=cluster-admin --serviceaccount=default:github-deploy

# Get token (Kubernetes 1.24+)
kubectl create token github-deploy --duration=8760h | base64 -w 0
```

## Alternative: Use service account token in workflow
Replace kubeconfig setup with token-based auth in deploy.yml