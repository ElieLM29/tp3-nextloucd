# Définition du cloud provider
  terraform {
    required_providers {
      scaleway = {
        source = "scaleway/scaleway"
      }
    }
    required_version = ">= 0.13"
  }
  provider "scaleway" {
   alias   = "p2"
   profile = "myProfile"
  }


# Création d'une instance Kubernetes

  resource "scaleway_k8s_cluster" "test-tf-k8s" {
    name             = "test-tf-k8s"
    description      = "cluster generate with terraform"
    version          = "1.23.0"
    cni              = "cilium"
    tags             = ["elie"]

    autoscaler_config {
      disable_scale_down              = false
      scale_down_delay_after_add      = "5m"
      estimator                       = "binpacking"
      expander                        = "random"
      ignore_daemonsets_utilization   = true
      balance_similar_node_groups     = true
      expendable_pods_priority_cutoff = -5
    }
  }

  resource "scaleway_k8s_pool" "test-tf-k8s" {
    cluster_id  = scaleway_k8s_cluster.test-tf-k8s.id
    name        = "test-tf-k8s"
    node_type   = "GP1-XS"
    size        = 1
    autoscaling = true
    autohealing = true
    min_size    = 1
    max_size    = 10
  }