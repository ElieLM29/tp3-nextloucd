# tp3-nextloucd


## Phase de test pour prendre en main kubernetes : Installation kubectl afin de pouvoir interragir avec notre cluster kubernetes préalablement créé

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```

```
chmod +x ./kubectl
```

```
sudo mv ./kubectl /usr/local/bin/kubectl
```

Il faut ensuite télécharger le fichier kubeconfig depuis l'espace client Scaleway, et pour nos tests nous copirons le contenu dans le fichier nommé "kubeconfig.yaml" : 

```
nano kubeconfig.yaml
```

```
export KUBECONFIG=kubeconfig.yaml 
```

On peut à présent voir nos cluster présent chez le cloud provider

```
kubectl get nodes
```

