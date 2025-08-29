echo -e "\n\e[38;5;10mCreation of the IoT cluster\e[0m"
k3d cluster create IoT

echo -e "\n\e[38;5;10mDeploying namepsaces\e[0m"
kubectl create namespace argocd
kubectl create namespace dev

echo -e "\n\e[38;5;10mDeploying ArgoCD into it's namespace\e[0m"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo -e "\n\e[38;5;10mWaiting for server availability\e[0m"
#kubectl wait --for=condition=available --timeout=180s deployement/argocd-server -n argocd

echo -e "\n\e[38;5;10mConnecting\e[0m"
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
argocd login localhost:8080 --username admin --password admin --insecure

echo -e "\n\e[38;5;10mLaunching app\e[0m"
kubectl port-forward svc/argocd-server -n argocd 8080:443

while ! nc -z localhost 8080; do   
  sleep 1
done

echo -e "\n\e[38;5;10mUpload app\e[0m"

argocd repo add https://github.com/Manualouest/IoT-mbirou
argocd app create wil-playground \
  --repo https://github.com/Manualouest/IoT-mbirou \
  --path manifest/app \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace dev \
  --project default \
  --sync-policy automated

kubectl port-forward svc/wil-playground -n dev 8888:8888 2>&1 >/dev/null &
