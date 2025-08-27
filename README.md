# 🚀 Inception of Things – Partie 1 : K3s et Vagrant

## Étapes à réaliser

1. **Créer le dossier `p1/` à la racine du repo** ✅

2. **Écrire un `Vagrantfile`**  ✅ 


5. **Activer l’accès SSH sans mot de passe aux deux VMs**  
   (Vagrant le permet via clé, vérifier avec `vagrant ssh tebandamS` et `vagrant ssh tebandamSW`)  
   ❌

6. **Provisionner les paquets de base (`curl`, `ca-certificates`)**  
   (via un script `scripts/install_base.sh`)  
   ❌

7. **Installer K3s sur `loginS` en mode server** et sur `loginSW` en mode agent,  
   avec un **K3S_TOKEN** commun et `K3S_URL=https://192.168.56.110:6443`  
   ❌

8. **Installer `kubectl`** (fourni par K3s côté serveur) et rendre le kubeconfig accessible à l’utilisateur  
   (copier `/etc/rancher/k3s/k3s.yaml` dans `/home/vagrant/` et exporter `KUBECONFIG`)  
   ❌

9. **Désactiver le swap** sur les deux VMs (préconisé pour K8s/K3s)  
   ❌

10. **Démarrer les VMs** avec `vagrant up` et attendre que l’agent rejoigne le server  
    ❌

11. **Vérifier le réseau/les IP** avec `ip a show eth1`  
    (elles doivent correspondre à `.110` et `.111`)  
    ❌

12. **Contrôler l’état du cluster** depuis `loginS` :  
    - `kubectl get nodes` → voir **2 nœuds** (server + agent)  
    - `systemctl status k3s` ou `systemctl status k3s-agent` si besoin  
    ❌

13. **Nettoyer/organiser le repo** :  
    - `p1/Vagrantfile`  
    - `p1/scripts/`  
    - `p1/confs/`  
    ❌

14. **Préparer la démo** : montrer une VM mal configurée vs bien configurée (exemples du sujet) et expliquer les choix  
    ❌
