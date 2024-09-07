provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_vcenter

  allow_unverified_ssl = var.vsphere_unverified_ssl
}

data "vsphere_datacenter" "dc" {
  name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_network" "mgmt_lan" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.name
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus         = var.cpu
  memory           = var.ram

  guest_id         = var.vm_guest_id

  network_interface {
    network_id   = "${data.vsphere_network.mgmt_lan.id}"
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = var.disksize
    eagerly_scrub    = false
    thin_provisioned = true
  }

  cdrom {
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    path         = var.iso_datastore_path
  }

  # Ensure the VM uses BIOS firmware
  firmware = "bios"

  #   # Cloud-init configuration (if applicable)
  #   extra_config = {
  #     "guestinfo.userdata" = base64encode(<<EOF
  # #cloud-config
  # autoinstall:
  #   apt:
  #     disable_components: []
  #     fallback: offline-install
  #     geoip: true
  #     mirror-selection:
  #       primary:
  #       - country-mirror
  #       - arches: &id001
  #         - amd64
  #         - i386
  #         uri: http://archive.ubuntu.com/ubuntu/
  #       - arches: &id002
  #         - s390x
  #         - arm64
  #         - armhf
  #         - powerpc
  #         - ppc64el
  #         - riscv64
  #         uri: http://ports.ubuntu.com/ubuntu-ports
  #     preserve_sources_list: false
  #     security:
  #     - arches: *id001
  #       uri: http://security.ubuntu.com/ubuntu/
  #     - arches: *id002
  #       uri: http://ports.ubuntu.com/ubuntu-ports
  #   codecs:
  #     install: false
  #   drivers:
  #     install: false
  #   identity:
  #     hostname: guest
  #     password: $6$JR..jbdfr0SRImOW$nxbruEGeGzx.n38qkN//1VIVnAKTTsN6Pu8BG.f4S6PBQnIPynjuaAa2ajDXdn7t5rG1h6SpThnHeCIzTAz1K0
  #     realname: guest
  #     username: guest
  #   kernel:
  #     package: linux-generic
  #   keyboard:
  #     layout: it
  #     toggle: null
  #     variant: ''
  #   locale: en_US.UTF-8
  #   network:
  #     ethernets:
  #       all:
  #         dhcp4: true
  #     version: 2
  #   oem:
  #     install: auto
  #   source:
  #     id: ubuntu-server
  #     search_drivers: false
  #   ssh:
  #     allow-pw: true
  #     authorized-keys: []
  #     install-server: true
  #   updates: security
  #   version: 1
  # EOF
  #     )
  #   }

  # # Wait for the VM to be created before provisioning
  # provisioner "remote-exec" {
  #   inline = [
  #     "mkdir -p /home/${var.ssh_username}/.ssh",
  #     "echo '${var.public_key}' >> /home/${var.ssh_username}/.ssh/authorized_keys",
  #     "chown -R ${var.ssh_username}:${var.ssh_username} /home/${var.ssh_username}/.ssh",
  #     "chmod 600 /home/${var.ssh_username}/.ssh/authorized_keys"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = var.ssh_username # from secrets
  #     password    = var.ssh_password # from secrets
  #     host        = vsphere_virtual_machine.vm.default_ip_address
  #   }
  # }
}