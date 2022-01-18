# tp3-nextloucd

## Prérequis :

Installer kubectl pour intéragir avec Kubernetes

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```

```
chmod +x ./kubectl
```

```
sudo mv ./kubectl /usr/local/bin/kubectl
```

Installer les paquets : 

```
apt-get install git & terraform
```

## 1 - Cloner le repo GIT

```
https://github.com/ElieLM29/tp3-nextloucd.git 
```

## 2 - Infra as Code avec Terraform

Nos fichiers .tf sont actuellement configuré afin de créer nos instances chez Scaleway.
Cela créera :
- Un cluster Kuvernetes Kapsule
- Un Load Balancer
- Un object storage
- Une base de données managées

Il suffit de lancer la commande : 

```
terraform plan
```
Afin de vérifier que notre syntaxe est correcte

Puis si tout est bon, de faire un apply : 

```
terraform apply
```

Une fois le cluster Kubernetes créé, il faudra télécharger le fichier kubeconfig.yaml, depuis l'espace client Scaleway, en cliant sur l'onglet Kubernetes, puis sur votre instance, et vous verrez le lien de téléchargement en bas de la page.

Lorsque vous aurez récupéré votre fichier, placez-le à la racine de votre repos GIT, et lancez la commande : 

```
export KUBECONFIG=kubeconfig.yaml 
```
puis :
```
kubectl1 apply -k .
```

Cela va créer nos pods et faire le lien avec la base de données et le stockage pour utiliser Nextcloud.

Pour voir nos pods : 
```
kubectl get pods
```

