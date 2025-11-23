#!/bin/bash

echo -e "\nCreating the cluster\n"
k3d cluster create iot

echo -e "\nAdding the namespaces\n"
kubectl create namespace argocd
kubectl create namespace dev

echo -e "\nAdding AgroCd in it's namespace\n"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo -e "\nWaiting availability of argocd-server in deployment.apps...\n"
kubectl wait --for=condition=available --timeout=180s deployment.apps/argocd-server -n argocd

while ! kubectl -n argocd get secret argocd-initial-admin-secret &> /dev/null; do
  echo -e "\nWaiting for argocd initial admin secret...\n"
  sleep 3
done

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > ./password.txt
ARGOCD_PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo -e "\nPort-forwarding to ArgoCD's API...\n"
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
PF_PID=$!

while ! nc -z localhost 8080; do   
  sleep 1
done

echo -e "\nSetting up the App\n"
ARGOCD_HOST=localhost:8080
ARGOCD_USER=admin

argocd login $ARGOCD_HOST --username $ARGOCD_USER --password $ARGOCD_PASS --insecure

sleep 1
argocd repo add https://github.com/Manualouest/IoT-mbirou
sleep 1
argocd app create wil-playground \
  --repo https://github.com/Manualouest/IoT-mbirou \
  --path manifest/app \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace dev \
  --project default \
  --sync-policy automated

