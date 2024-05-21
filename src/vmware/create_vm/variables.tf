variable "vsphere_user" {
  description = "vSphere API username"
  type        = string
  sensitive   = true
}

variable "vsphere_password" {
  description = "vSphere API password"
  type        = string
  sensitive   = true
}

variable "vsphere_vcenter" {
  description = "vSphere vCenter server address"
  type        = string
  sensitive   = true
}

variable "public_key" {
  description = "SSH public key to be used for authentication"
  type        = string
  sensitive   = true
}

variable "ssh_username" {
  description = "Username for SSH access to the VM"
  type        = string
  sensitive   = true
}

variable "cpu" {
  description = "Number of CPUs for the VM"
  type        = number
}

variable "cores_per_socket" {
  description = "Number of cores per socket"
  type        = number
}

variable "ram" {
  description = "Memory for the VM in MB"
  type        = number
}

variable "disksize" {
  description = "Disk size in GB for the VM"
  type        = number
}

variable "vm_guest_id" {
  description = "Type of guest OS"
  type        = string
}

variable "vsphere_unverified_ssl" {
  description = "Allow unverified SSL for vSphere connection"
  type        = bool
}

variable "vsphere_datacenter" {
  description = "Datacenter in vSphere"
  type        = string
}

variable "vsphere_cluster" {
  description = "Cluster in the datacenter"
  type        = string
}

variable "vm_datastore" {
  description = "Datastore for the VM"
  type        = string
}

variable "vm_network" {
  description = "Network label for the VM"
  type        = string
}

variable "vm_domain" {
  description = "Domain for the VM"
  type        = string
}

variable "dns_server_list" {
  description = "List of DNS servers for the VM"
  type        = list(string)
}

variable "name" {
  description = "Name of the VM"
  type        = string
}

variable "ipv4_address" {
  description = "Static IPv4 address for the VM"
  type        = string
}

variable "ipv4_gateway" {
  description = "Gateway for the VM's subnet"
  type        = string
}

variable "ipv4_netmask" {
  description = "Netmask for the VM's IPv4 address"
  type        = string
}

variable vm_template_folder {
  description = "Folder where the VM template is stored"
  type        = string
}

variable "vm_template_name" {
  description = "Template name to clone the VM from"
  type        = string
}
