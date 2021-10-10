# K8S-GitOps-and-ArgoCD
K8S-GitOps-and-ArgoCD

### Tools
- Docker
- Kubernetes [ https://kubernetes.io/docs/tasks/tools/ ]
- Kind [ https://kind.sigs.k8s.io/docs/user/quick-start ]
- Kustomize [ https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/ ]

### Build docker image
```
docker build -t ricardocosta94/kga:latest .
```

### Create cluster with Kind:
```
kind create cluster --name=argocd
```

### Change context with kubectl cli
```
kubectl cluster-info --context kind-argocd
kubectl get nodes
```

### Apply deployment in project base dir
```
kubectl apply -f k8s/deployment.yaml
kubectl get pods
```

### Create service in project base dir
[ https://kubernetes.io/docs/concepts/services-networking/service/ ]
```
kubectl apply -f k8s/service.yaml
kubectl get svc
kubectl port-forward svc/nodeapp 3000:3000
```

### Kustomize auto generate kubernetes manifest
```
cd k8s && kustomize build
```