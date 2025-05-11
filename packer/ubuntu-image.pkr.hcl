packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

variable "ssh_private_key" {
  type    = string
  default = "~/.ssh/cloudit-key"
}

source "amazon-ebs" "ubuntu" {
  region                      = "us-east-1"
  instance_type               = "t2.micro"
  ssh_username                = "ubuntu"
  ssh_private_key_file        = var.ssh_private_key
  ssh_keypair_name            = "cloudit-key"
  ami_name                    = "devops-custom-ami-${formatdate("YYYYMMDDHHmmss", timestamp())}"
  associate_public_ip_address = true
  ssh_agent_auth              = false

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    playbook_file = "../ansible/playbook.yml"

    extra_arguments = [
    "--extra-vars", "ansible_user=ubuntu",
    "--extra-vars", "ansible_remote_tmp=/tmp/.ansible"
  ]

    use_proxy = false
  }
}
