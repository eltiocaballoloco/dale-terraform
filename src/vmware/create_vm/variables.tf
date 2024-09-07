variable "vsphere_user" {
  description = "The vSphere user"
}

variable "vsphere_password" {
  description = "The vSphere password"
  sensitive   = true
}

variable "vsphere_vcenter" {
  description = "The vSphere vCenter server"
}

variable "esxi_host_name" {
  description = "ESXi hostname"
}

variable "vsphere_unverified_ssl" {
  description = "Allow unverified SSL certificates"
  default     = true
}

variable "vm_datastore" {
  description = "The datastore where the VM will be stored"
}

variable "vm_network" {
  description = "The network to connect the VM"
}

variable "vm_guest_id" {
  description = "The guest ID, e.g., 'ubuntu64Guest'"
  default     = "ubuntu64Guest"
}

variable "name" {
  description = "The name of the VM"
}

variable "cpu" {
  description = "Number of vCPUs"
}

variable "cores_per_socket" {
  description = "Number of cores per socket"
}

variable "ram" {
  description = "Amount of RAM in MB"
}

variable "disksize" {
  description = "Disk size in GB"
}

variable "dns_server_list" {
  description = "List of DNS servers"
  type        = list(string)
}

variable "ipv4_address" {
  description = "IPv4 address of the VM"
}

variable "ipv4_gateway" {
  description = "IPv4 gateway for the VM"
}

variable "ipv4_netmask" {
  description = "Netmask for the VM's IPv4 address"
}

variable "iso_datastore_path" {
  description = "The path to the ISO file in the datastore"
}

variable "public_key" {
  description = "The SSH public key to be added to the VM"
}

variable "ssh_username" {
  description = "The username for SSH access"
}

variable "ssh_password" {
  description = "The password for SSH access"
}

variable "new_ssh_password" {
  description = "The new password for SSH access"
}

variable "private_key_path" {
  description = "The path to the private key used for SSH"
}
