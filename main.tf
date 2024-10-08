provider "aws" {
  region = var.demo-parameters.region
}


resource "aws_instance" "ec2_instances" {
  for_each = var.mke3_instances                    # var.k0s_instances or var.mke3_instances

  ami                    = var.demo-parameters.ami
  instance_type          = each.value.instance_type
  subnet_id              = var.demo-parameters.subnet
  vpc_security_group_ids = [var.demo-parameters.sg]
  key_name = var.demo-parameters.ssh_key

  root_block_device {
    volume_size           = each.value.storage.volume_size
    volume_type           = each.value.storage.volume_type
    delete_on_termination = each.value.storage.delete_on_termination
  }

  tags = {
    Name = format("%s-%s", var.demo-parameters.name, each.value.name) 
    Role = each.value.role
  }
}

locals {
  hosts = [
    for instance in aws_instance.ec2_instances :
    {
      address = instance.public_ip
      user    = "ubuntu"
      port    = 22
      keyPath = var.demo-parameters.cert_path
      role    = instance.tags["Role"]
    }
  ]
}

output "k0sctl_config" {
  description = "The k0sctl configuration file content"
  value       = templatefile("${path.module}/templates/k0sctl.tmpl", { hosts = local.hosts })
  sensitive   = false
}

output "launchpad_config"{
  description = "The launchpad configuration file content"
  value       = templatefile("${path.module}/templates/launchpad.tmpl", { hosts = local.hosts })
  sensitive   = false
}