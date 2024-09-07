# secrets.tfvars
```bash
vsphere_user     = "v-sphere-usr"
vsphere_password = "v-sphere-pwd"
vsphere_vcenter  = "v-sphere.dalecosta.com"
esxi_host_name   = "srv1.lan"
public_key       = "ssh-rsa ABCDEf4567"
private_key_path = "/path/to/priv/key/.ssh/id_rsa"
ssh_username     = "ssh_usr"
ssh_password     = "ssh_pwd"
new_ssh_password = "new_pwd"
```


# terraform.tfvars
```bash
cpu                    = 4
cores_per_socket       = 1
ram                    = 65536 # in MB
disksize               = 500  # in GB
vm_guest_id            = "ubuntu64Guest"
vsphere_unverified_ssl = true
vm_datastore           = "/ha-datacenter/datastore/datastore1"
vm_network             = "VM Network"
dns_server_list        = ["172.18.1.1", "8.8.8.8"]
name                   = "k8s-worker-node-2-2-srv1"
ipv4_address           = "172.18.1.234"
ipv4_gateway           = "172.18.1.1"
ipv4_netmask           = "24"
iso_datastore_path     = "ISOs/ubuntu-24.04.1-live-server-amd64.iso"
```


# How use

```bash
terraform init
```bash

```bash
terraform plan \                                                                                              
  -var-file="/path/to/repo/dale-terraform/src/vmware/create_vm/terraform.tfvars" \
  -var-file="/path/to/repo/dale-terraform/src/vmware/create_vm/secrets.tfvars" \
  -out=“terraform_plan.out"
```

```bash
terraform apply "terraform_plan.out"
```
