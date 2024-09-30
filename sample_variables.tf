variable "demo-parameters"{
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

variable "instances" {
  description = "Map of instances with specific configurations"
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
        volume_size = 20
        volume_type = "gp2"
      }
    },
    "instance2" = {
      instance_type = "c5n.metal"
      name          = "kubevirt-worker"
      role          = "worker"
      storage = {
        volume_size = 50
        volume_type = "gp2"
      }
    },
    "instance3" = {
      instance_type = "t2.xlarge"
      name          = "k0s-worker"
      role          = "worker"
      storage = {
        volume_size = 20
        volume_type = "gp2"
      }
    }
  }
}
