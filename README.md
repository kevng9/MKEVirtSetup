# MKEVirtSetup
## Overview
MKEVirtSetup is a Terraform script designed to set up an AWS environment for demonstrating Mirantis Kubernetes Engine (MKE) virtualization capabilities. This automation simplifies the provisioning of the necessary AWS infrastructure to facilitate a seamless MKE virtualization demo.

### To create environment
`terraform init`

`terraform validate`

`terraform apply`

### To create k0sctl config file
`terraform output -raw k0sctl_config > k0sctl-config.yaml`

### To create launchpad config file
`terraform output -raw launchpad_config > launchpad.yaml`

### Installing kubevirt
[https://docs.mirantis.com/mke/3.7/ops/mke-virtualization/deploy-kubevirt.html](https://docs.mirantis.com/mke/3.7/ops/mke-virtualization/deploy-kubevirt.html)

### To clean up environment
`terraform destroy`
