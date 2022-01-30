# tp3-nextcloud

## Prérequis :

Avoir un nom de domaine

Créer un fichier de configuration avec nos credentials Scaleway pour pouvoir intéragir avec leurs API (Cf: https://registry.terraform.io/providers/scaleway/scaleway/latest/docs#shared-configuration-file) 

Pour faire court, il faut créer un fichier dans votre home `$HOME/.config/scw/config.yaml` puis, coller ceci à l'intérieur de votre fichier :

```
profiles:
  myProfile:
    access_key: xxxxxxxxxxxxxxxxxxxx
    secret_key: xxxxxxxx-xxx-xxxx-xxxx-xxxxxxxxxxx
    default_organization_id: xxxxxxxx-xxx-xxxx-xxxx-xxxxxxxxxxx 
    default_project_id: xxxxxxxx-xxx-xxxx-xxxx-xxxxxxxxxxx
    default_zone: fr-par-2
    default_region: fr-par
    api_url: https://api.scaleway.com
    insecure: false
```
Vous devrez ensuite modifier les différentes valeurs afin d'y renseigner vos crédentials Scaleway et la zone et région souhaitée. Ces crédentials sont visibles dans votre espace client en cliquant sur votre nom, puis "Identifiants".

### Pour le reste des informations ci-dessous, il est déconseillé d'effectuer ces commandes en tant que root

Installez kubectl pour intéragir avec Kubernetes

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```
Rendez le binaire kubectl exécutable
```
chmod +x ./kubectl
```
Déplacez le binaire dans votre PATH
```
sudo mv ./kubectl /usr/local/bin/kubectl
```

Installez les paquets : 

```
sudo apt-get install git
```

- Installez Terraform : 

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

```
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```
```
sudo apt-get update
```

```
sudo apt install terraform
```


## 1 - Cloner le repo GIT

```
git clone https://github.com/ElieLM29/tp3-nextloucd.git 
```

## 2 - Infra as Code avec Terraform

L'objectif de ce projet est d'automatiser le déploiement de Nextcloud dans un cluster Kubernetes. 

Pour l'instant notre POC consiste à générer un cluster Kubernetes, puis de créer plusieurs pods avec : 

- un pod Nextcloud
- un pod mariadb
- un pod redis


Pour créer notre instance Kubernetes avec terraform, veuillez suivre les étapes ci-dessous :

Placez-vous dans le dossier du repos git, puis lancez la commande :
```
terraform plan
```
Cela nous permet de vérifier que notre syntaxe est correcte

Puis si tout est bon, faire un apply : 

```
terraform apply
```

Une fois le cluster Kubernetes créé, il faudra télécharger le fichier kubeconfig.yaml, depuis l'espace client Scaleway, en cliquant sur l'onglet Kubernetes, puis sur votre instance, et vous verrez le lien de téléchargement en bas de la page.

Pensez également à activer l'option "Déployer un ingress controller " et sélectionnez "Ningx".

Lorsque vous aurez récupéré votre fichier, copiez-collez le contenu de ce dernier dans le fichier `kubeconfig.yml` présent à la racine de notre repos GIT et lancez la commande : 

```
export KUBECONFIG=kubeconfig.yml 
```
puis :

```
kubectl apply -k .
```

Cela va créer nos pods, vous pouvez le voir avec la commande :

```
kubectl get pods
```

Pour récupérer l'adresse IP publique du pod : 

```
kubectl get ing
```

Il faudra ensuite faire pointer votre nom de domaine vers cette adresse IP pour accéder à votre Nextcloud.

Pensez également à éditer le fichier de configuration `nextcloud-ingress.yaml` afin de remplacer le host par votre nom de domaine.

## Optimisation :

Par contrainte de temps, nous avons avant tout priviligié l'automatisation et le fonctionnement de la solution Nextcloud.

Cependant, notre POC peut être amélioré de plusieurs manières. 

La première, serait de mettre en place un fichier secret, pour nos mots de passes. 

La seconde, il faudrait que les données Nextcloud, et de la base de données utilisent un stockage type block storage, ou object storage. Car pour l'instant, si un pod se fait supprimer, le stockage des données est perdu, ce qui est évidemment pas possible sur un environnement en prod.