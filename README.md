# tp3-nextloucd

## Prérequis :

Suivre la documentation Scaleway pour créer un fichier de configuration avec nos credentials : 

https://registry.terraform.io/providers/scaleway/scaleway/latest/docs#shared-configuration-file

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

Pour l'instant notre POC consiste à générer une instance Kubernetes, puis de créer plusieurs pods avec : 

- un pod Nextcloud
- un pod mariadb
- un pod redis

Une fois cela fonctionnel, on testera plus tard de créer un volume persistant pour la bdd et nextcloud.


Pour créer notre instance Kubernetes avec terraform, veuillez suivre les étapes ci-dessous :

```
terraform plan
```
Afin de vérifier que notre syntaxe est correcte

Puis si tout est bon, faire un apply : 

```
terraform apply
```

Une fois le cluster Kubernetes créé, il faudra télécharger le fichier kubeconfig.yaml, depuis l'espace client Scaleway, en cliant sur l'onglet Kubernetes, puis sur votre instance, et vous verrez le lien de téléchargement en bas de la page.

Lorsque vous aurez récupéré votre fichier, placez-le à la racine de votre repos GIT, et renommez-le en `kubeconfig.yml` et lancez la commande : 

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

