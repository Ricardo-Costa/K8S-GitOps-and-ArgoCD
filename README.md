# K8S - GitOps - ArgoCD

> This project show how build a **Continuous Deployment** with Kubernetes, GitHub Actions and AgorCD.

### Tools
- Docker
- Kubernetes [ https://kubernetes.io/docs/tasks/tools/ ]
- Kind [ https://kind.sigs.k8s.io/docs/user/quick-start ]
- Kustomize [ https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/ ]
- Argo CD [ https://argo-cd.readthedocs.io/en/stable/getting_started/ ]

### Build docker image
```bash
docker build -t ricardocosta94/kga:latest .
```

### Create cluster with Kind:
```bash
kind create cluster --name=argocd
```

### Change context with kubectl cli
```bash
kubectl cluster-info --context kind-argocd
kubectl get nodes
```

### Apply deployment in project base dir
```bash
kubectl apply -f k8s/deployment.yaml
kubectl get pods
```

### Create service in project base dir
[ https://kubernetes.io/docs/concepts/services-networking/service/ ]
```bash
kubectl apply -f k8s/service.yaml
kubectl get svc
kubectl port-forward svc/nodeapp 3000:3000
```

### Kustomize auto generate kubernetes manifest
```bash
cd k8s && kustomize build
```

### Argo CD steps
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
> More details at: https://argo-cd.readthedocs.io/en/stable/getting_started/

### Delete old deploy and service
```bash
kubectl get deploy
kubectl delete deploy nodeapp
kubectl delete svc nodeapp
```

### Create new namespace
```bash
kubectl create namespace nodeapp
```

### Start application by service and namespace
```bash
kubectl port-forward svc/nodeapp 3000:3000 -n nodeapp
```