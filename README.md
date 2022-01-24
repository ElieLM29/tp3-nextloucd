# tp3-nextloucd

## Prérequis :

- Avoir un nom de domaine

- Suivre la documentation Scaleway pour créer un fichier de configuration avec nos credentials : 

https://registry.terraform.io/providers/scaleway/scaleway/latest/docs#shared-configuration-file

- Installer kubectl pour intéragir avec Kubernetes

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
apt-get install git
```

Installer Terraform : 

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

```
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

```
sudo apt install terraform
```


## 1 - Cloner le repo GIT

```
git clone https://github.com/ElieLM29/tp3-nextloucd.git 
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

Une fois le cluster Kubernetes créé, il faudra télécharger le fichier kubeconfig.yaml, depuis l'espace client Scaleway, en cliquant sur l'onglet Kubernetes, puis sur votre instance, et vous verrez le lien de téléchargement en bas de la page.

Activez également l'option "Deploy an Ingress Controller" et sélectionnez "Ningx".

Lorsque vous aurez récupéré votre fichier, copiez-collez le contenu de ce dernier dans le fichier `kubeconfig.yml` présent à la racine de notre repos GIT et lancez la commande : 

```
export KUBECONFIG=kubeconfig.yml 
```
puis :
```
kubectl apply -k .
```

Cela va créer nos pods et faire le lien avec la base de données et le stockage pour utiliser Nextcloud.

Pour voir nos pods : 
```
kubectl get pods
```

Pour récupérer l'adresse IP publique du pod : 

```
kubectl get ing
```

Il faudra ensuite faire pointer votre nom de domaine vers cette adresse IP pour accéder à votre Nextcloud.

Pensez également à éditer le fichier de configuration `nextcloud-ingress.yaml` afin de remplacer le host par votre nom de domaine.