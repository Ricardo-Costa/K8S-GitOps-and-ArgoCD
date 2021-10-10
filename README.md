# K8S-GitOps-and-ArgoCD
K8S-GitOps-and-ArgoCD

### Tools
- Docker
- Kubernetes [ https://kubernetes.io/docs/tasks/tools/ ]
- Kind [ https://kind.sigs.k8s.io/docs/user/quick-start ]
- Kustomize [ https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/ ]
- Argo CD [ https://argo-cd.readthedocs.io/en/stable/getting_started/ ]

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

### Argo CD steps
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
> More details at: https://argo-cd.readthedocs.io/en/stable/getting_started/

### Delete old deploy and service
```
kubectl get deploy
kubectl delete deploy nodeapp
kubectl delete svc nodeapp
```

### Create new namespace
```
kubectl create namespace nodeapp
```


### Start application by service and namespace
```
kubectl port-forward svc/nodeapp 3000:3000 -n nodeapp
```