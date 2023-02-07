terraform {
  backend "swift" {
    region_name       = "GRA"
    container         = "terraform-state-prod-projects"
    archive_container = "terraform-state-prod-projects-archive"
  }
}

provider "openstack" {
  alias = "ovh"
}

module "server_prod_1" {
  source              = "../../modules/basic-instance"
  network_name        = "Ext-net"
  region              = "GRA11"
  machine_type        = "d2-4"
  key_pair_name       = "my_ssh_key"
  security_group      = "webserver_secgroup"
  name                = "server_prod_1"
  metadata            = {
    "environnement" = "prod"
  }
}