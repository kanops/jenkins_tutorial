terraform {
  required_providers {
    ovh = {
      source = "terraform-providers/ovh"
    }
    openstack = {
      source = "terraform-providers/openstack"
    }
  }
  required_version = ">= 0.14"
}
