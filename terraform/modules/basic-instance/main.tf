provider "openstack" {
  alias = "ovh"
}

resource "openstack_networking_secgroup_v2" "webserver_secgroup" {
  region      = "GRA11"
  name        = "webserver_secgroup"
  description = "Groupe de sécurité pour le HTTP et HTTPS"
}

# SSH
resource "openstack_networking_secgroup_rule_v2" "webserver_secgroup_rule_ssh" {
  direction         = "ingress"
  region            = "GRA11"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.webserver_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "webserver_secgroup_rule_http" {
  direction         = "ingress"
  region            = "GRA11"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.webserver_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "webserver_secgroup_rule_https" {
  direction         = "ingress"
  region            = "GRA11"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.webserver_secgroup.id
}

data "openstack_networking_network_v2" "net_public" {
  name = "Ext-Net"
}

resource "time_sleep" "wait_20_seconds" {
  create_duration = "20s"
}

resource "openstack_networking_port_v2" "public" {
  name       = "basic-instance-public"
  network_id = data.openstack_networking_network_v2.net_public.id
  security_group_ids = [
    openstack_networking_secgroup_v2.webserver_secgroup.id
  ]
  admin_state_up = "true"

  depends_on = [time_sleep.wait_20_seconds]
}


resource "openstack_compute_instance_v2" "node" {
  name = var.name
  image_name = var.image_name
  flavor_name = var.machine_type
  region = var.region
  key_pair = var.key_pair_name

  network {
    port = openstack_networking_port_v2.public.id
  }

  metadata = var.metadata
}

resource "local_file" "host_ip" {
    content  = openstack_compute_instance_v2.node.network[0].fixed_ip_v4
    filename = "host_ip.txt"
}