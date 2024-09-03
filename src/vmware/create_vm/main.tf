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

  # Cloud-init configuration (if applicable)
  extra_config = {
    "guestinfo.userdata" = base64encode(<<EOF
#cloud-config
users:
  - name: ${var.ssh_username}
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${var.public_key}
    shell: /bin/bash
    lock_passwd: false
    passwd: ${var.ssh_password}
    
# Set static IP configuration
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: false
      addresses:
        - ${var.ipv4_address}/${var.ipv4_netmask}
      gateway4: ${var.ipv4_gateway}
      nameservers:
        addresses: ${jsonencode(var.dns_server_list)}
EOF
    )
  }

  # Wait for the VM to be created before provisioning
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/${var.ssh_username}/.ssh",
      "echo '${var.public_key}' >> /home/${var.ssh_username}/.ssh/authorized_keys",
      "chown -R ${var.ssh_username}:${var.ssh_username} /home/${var.ssh_username}/.ssh",
      "chmod 600 /home/${var.ssh_username}/.ssh/authorized_keys"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_username # from secrets
      private_key = file(var.private_key_path) # from secrets
      host        = vsphere_virtual_machine.vm.default_ip_address
    }
  }
}
