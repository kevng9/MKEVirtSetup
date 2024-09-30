/*variable "demo-parameters"{
    description = "Global parameters for demo"
    type = object({
        name          = string
        ssh_key       = string
        ami           = string
        region        = string
        cert_path = string
        vpc           = string
        sg            = string
        subnet        = string
    })
    default = {
        name      = "your_name"                   #change this
        ssh_key   = "your_aws_key"             #change this
        ami       = "ami-0a0e5d9c7acc336f1"
        region    = "us-east-1"                 #change this
        cert_path = "path_to_local_cert" #change this 
        vpc       = "vpc-a8467dd2"
        sg        = "sg-016a3c924f7e68f8d"
        subnet    = "subnet-81348bcc"
    }
}

variable "k0s_instances" {
  description = "Configurations for k0s cluster"
  type = map(object({
    instance_type = string
    name          = string
    role          = string
    storage = object({
      volume_size           = number
      volume_type           = string
      delete_on_termination = optional(bool)
      iops                  = optional(number)
      throughput            = optional(number)
    })
  }))
  default = {
    "instance1" = {
      instance_type = "t2.xlarge"
      name          = "k0s-controller"
      role          = "controller"
      storage = {
        volume_size = 30
        volume_type = "gp2"
        delete_on_termination = true
      }
    },
    "instance2" = {
      instance_type = "c5n.metal"             # need bare metal for virtualization
      name          = "kubevirt-worker"
      role          = "worker"
      storage = {
        volume_size = 80
        volume_type = "gp2"
        delete_on_termination = true
      }
    },
    "instance3" = {
      instance_type = "t2.xlarge"
      name          = "k0s-worker"
      role          = "worker"
      storage = {
        volume_size = 30
        volume_type = "gp2"
        delete_on_termination = true
      }
    }
  }
}


variable "mke3_instances" {
  description = "Configurations for MKE3.X cluster"
  type = map(object({
    instance_type = string
    name          = string
    role          = string
    storage = object({
      volume_size           = number
      volume_type           = string
      delete_on_termination = optional(bool)
      iops                  = optional(number)
      throughput            = optional(number)
    })
  }))
  default = {
    "instance1" = {
      instance_type = "c4.2xlarge"
      name          = "mke-controller"
      role          = "manager"
      storage = {
        volume_size = 80
        volume_type = "gp2"
        delete_on_termination = true
      }
    },
    "instance2" = {
      instance_type = "c5n.metal"             # need bare metal for virtualization
      name          = "kubevirt-worker"
      role          = "worker"
      storage = {
        volume_size = 80
        volume_type = "gp2"
        delete_on_termination = true
      }
    },
    "instance3" = {
      instance_type = "c4.2xlarge"
      name          = "mke-worker"
      role          = "worker"
      storage = {
        volume_size = 80
        volume_type = "gp2"
        delete_on_termination = true
      }
    }
  }
}
*/