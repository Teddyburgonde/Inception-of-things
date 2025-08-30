#!/usr/bin/env bash
set -euo pipefail

# Installe K3s (IP déjà conforme à ton Vagrantfile: 192.168.56.110)
curl -sfL https://get.k3s.io | sh -s - --node-ip=192.168.56.110 --write-kubeconfig-mode=644

# Applique d'abord les ConfigMaps (ils doivent exister avant les pods)
kubectl apply -f /vagrant/confs/app1-configmap.yaml
kubectl apply -f /vagrant/confs/app2-configmap.yaml
kubectl apply -f /vagrant/confs/app3-configmap.yaml

# Puis les Deployments/Services
kubectl apply -f /vagrant/confs/app1-deployment.yaml
kubectl apply -f /vagrant/confs/app2-deployment.yaml
kubectl apply -f /vagrant/confs/app3-deployment.yaml

kubectl apply -f /vagrant/confs/app1-service.yaml
kubectl apply -f /vagrant/confs/app2-service.yaml
kubectl apply -f /vagrant/confs/app3-service.yaml

# Enfin l'Ingress
kubectl apply -f /vagrant/confs/app-ingress.yaml

echo "Done."

