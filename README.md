# 🚀 Inception of Things – Partie 2 : K3d et Argo CD

## 🎯 Objectif
Mettre en place un cluster Kubernetes léger avec **K3d**, installer **Argo CD** et déployer une première application en mode **GitOps**.

---

## 📚 Notions à connaître
- **Docker** : conteneurs vs VM, commandes de base (`docker ps`, `docker images`, `docker run`).
- **K3d** : créer, gérer et supprimer un cluster Kubernetes dans Docker.
- **kubectl** : commandes essentielles pour interagir avec le cluster.
- **Argo CD** : installation, accès à l’UI, gestion des applications.
- **GitOps** : Git comme source de vérité → Argo CD déploie automatiquement.

---

## ✅ Étapes à réaliser

1. **Installer Docker** sur ta machine hôte  |✅|

2. **Installer K3d** (outil qui lance K3s dans Docker)  |❌|

3. **Créer un cluster K3d minimal**  |❌|
   - Exemple : `k3d cluster create iot-cluster --servers 1 --agents 2`

4. **Vérifier le cluster avec kubectl**  
   - `kubectl get nodes`  
   - `kubectl get pods -A`  
   ❌

5. **Installer Argo CD dans le cluster**  |❌|
   - `kubectl create namespace argocd`  
   - `kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`  

6. **Accéder à l’UI Argo CD**  |❌|
   - `kubectl port-forward svc/argocd-server -n argocd 8080:443`  
   - Interface accessible sur [https://localhost:8080](https://localhost:8080)  

7. **Récupérer le mot de passe admin Argo CD**  |❌|
   - `kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d`  

8. **Déployer une application simple avec Argo CD**  |❌|
   - Exemple : un Nginx ou une page HTML depuis un repo Git.  

9. **Vérifier que l’application est bien déployée dans le cluster** |❌| 
   - `kubectl get pods -n <namespace>`  
   - `kubectl get svc -n <namespace>`  

10. **Documenter ton travail dans le dossier `p2/`**  |❌|
   - `Vagrantfile` (si besoin pour tests Docker/K3d)  
   - Manifests Argo CD / App  
   - README clair avec captures / explications  

---

✅
