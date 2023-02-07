terraform {
  required_providers {
    ovh = {
      source = "terraform-providers/ovh"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
  required_version = ">= 0.14"
}
