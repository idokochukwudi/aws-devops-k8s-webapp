# 🛠️ Packer + Ansible AMI Provisioning: Troubleshooting Journey

This document outlines the step-by-step troubleshooting process and lessons learned while provisioning a custom AMI using **Packer** and **Ansible**.

---

## ✅ Goal

- Build a custom AMI based on Ubuntu 20.04 using Packer.
- Use Ansible as a provisioner to install Docker, Nginx, and configure the server.
- Automate everything via an HCL Packer template and Ansible playbook.

---

## 🔧 Final Working Setup

### ✅ `ubuntu-image.pkr.hcl`

```hcl
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
```

## 🧾 Final Working Ansible Playbook (playbook.yml)

```
---
- name: Configure base Ubuntu server
  hosts: all
  become: true

  tasks:
    - name: Ensure Ansible temp directory exists
      file:
        path: /tmp/.ansible
        state: directory
        mode: '0777'

    - name: Update APT packages
      apt:
        update_cache: yes
      become: true

    - name: Install Docker
      apt:
        name: docker.io
        state: present
      become: true

    - name: Install Nginx
      apt:
        name: nginx
        state: present
      become: true

    - name: Enable and start Docker
      systemd:
        name: docker
        enabled: yes
        state: started
      become: true
```

## 🧩 Key Errors, Solutions & Lessons Learned

### 🔴 Error 1: template: `root:1:31:` executing "`root`" at <`build`>: wrong number of args

- **Cause:** We tried using {{build.SSHPrivateKey}} inside extra_arguments.

- **Fix:** Replaced it with a declared variable:

```
variable "ssh_private_key" {
  type    = string
  default = "~/.ssh/cloudit-key"
}
```

**Lesson:** Avoid using template functions in unsupported contexts. Use variables instead for clarity and compatibility.

### 🔴 Error 2: Ansible Attempting to SSH into localhost

- **Cause:** Ansible defaulted to `127.0.0.1` because no remote inventory or user was specified.

- **Fix:** Passed `SSH` variables via `extra_arguments`:

```
extra_arguments = [
  "--extra-vars", "ansible_user=ubuntu",
  "--extra-vars", "ansible_remote_tmp=/tmp/.ansible"
]
```

**Lesson:** Always specify the remote user and control how Ansible connects. Defaults can fail silently or mislead you.

### 🔴 Error 3: APT Cache Fails - `Couldn't create temporary file`

- **Cause:** Ansible couldn’t write to `/tmp`, likely due to ownership/permission issues.

- **Fix:** Explicitly ensured the `/tmp` directory existed and was correctly owned:

```
- name: Ensure Ansible temp directory exists
  file:
    path: "/tmp"
    state: directory
    mode: '0700'
    owner: ubuntu
    group: ubuntu
```

**Lesson:** Critical system directories like /tmp must have appropriate ownership and permissions.

### 🔴 Error 4: Ansible Tasks Failed Due to Permissions (`permission denied`)

- **Cause:** Tasks like installing packages and starting services failed without root privileges.

- **Fix:** Added `become: yes` at the play level:

**Lesson:** Tasks that require elevated privileges (like `APT` or `systemd`) must use `become: true`.

