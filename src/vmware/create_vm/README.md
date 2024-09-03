# secrets.tfvars

vsphere_user     = "vmware-usr"
vsphere_password = "vmware-pwd"
vsphere_vcenter  = "vmware-srv1.domain.com"
esxi_host_name   = "srv1.lan"
public_key       = "ssh-rsa ABCDE1234"
private_key_path = "/home/youruser/.ssh/id_rsa"
ssh_username     = "ssh-usr"
ssh_password     = "ssh-pwd"



# terraform.tfvars

cpu                    = 4
cores_per_socket       = 1
ram                    = 32768 # in MB
disksize               = 200  # in GB
vm_guest_id            = "ubuntu64Guest"
vsphere_unverified_ssl = true
vm_datastore           = "/ha-datacenter/datastore/datastore1"
vm_network             = "VM Network"
dns_server_list        = ["192.168.3.1", "8.8.8.8"]
name                   = "k8s-master-node-1-1-srv1"
ipv4_address           = "192.168.3.234"
ipv4_gateway           = "192.168.3.1"
ipv4_netmask           = "24"
iso_datastore_path     = "ISOs/ubuntu-24.04.1-live-server-amd64.iso"

# How use

```bash
terraform init
```

```bash
terraform plan \                                                                                              
  -var-file="/path/to/repo/dale-terraform/src/vmware/create_vm/terraform.tfvars" \
  -var-file="/path/to/repo/dale-terraform/src/vmware/create_vm/secrets.tfvars" \
  -out=“terraform_plan.out"
```

```bash
terraform apply "terraform_plan.out"
```
