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
  resource "scaleway_instance_ip" "public_ip" {}
  resource "scaleway_instance_volume" "data" {
    size_in_gb = 30
    type = "l_ssd"
  }
  resource "scaleway_instance_server" "my-instance" {
    type  = "DEV1-L"
    image = "ubuntu_focal"

    tags = [ "terraform instance", "my-instance" ]

    ip_id = scaleway_instance_ip.public_ip.id

    additional_volume_ids = [ scaleway_instance_volume.data.id ]

    root_volume {
      # The local storage of a DEV1-L instance is 80 GB, subtract 30 GB from the additional l_ssd volume, then the root volume needs to be 50 GB.
      size_in_gb = 50
    }
  }
  # Object storage
  resource "scaleway_object_bucket" "some_bucket" {
    name = "bucket-tf-elie"
    region = "fr-par"
    acl  = "private"
    }

  # Load balancer
  resource "scaleway_lb_ip" "ip" {
}

  resource "scaleway_lb" "base" {
    ip_id  = scaleway_lb_ip.ip.id
    zone = "fr-par-1"
    type   = "LB-S"
    release_ip = true
}