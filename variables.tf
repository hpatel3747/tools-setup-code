variable "tools" {
  default = {

    vault = {
      port          = 8200
      volume_size   = 20
      instance_type = "t3.small"
      policy_list = ["ec2:DescribeKeyPairs"]
    }

    github-runner = {
      port          = 80 # Just a dummy port
      volume_size   = 30
      instance_type = "t3.small"
      policy_list = ["*"]
    }

  }
}

variable "zone_id" {
  default = "Z034492616CL1VL5T8KC8"
}

variable "domain_name" {
  default = "hptldevops.online"
}

