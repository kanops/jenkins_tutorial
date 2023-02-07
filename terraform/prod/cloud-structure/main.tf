provider "openstack" {
  alias = "ovh"
}

provider "ovh" {
  endpoint = "ovh-eu"
}

terraform {
  backend "swift" {
    region_name       = "GRA"
    container         = "terraform-state-prod-cloud-structure"
    archive_container = "terraform-state-prod-cloud-structure-archive"
  }
}

resource "openstack_compute_keypair_v2" "my_ssh_key" {
  provider = openstack.ovh
  name = "my_ssh_key"
  public_key = "ssh-rsa....user@home"
  region = "GRA11"
}