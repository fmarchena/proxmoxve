terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_lxc" "aws_lcx_docker_minimo" {
  target_node = var.pm_target_node
  hostname    = var.pm_hostname
  ostemplate  = var.pm_ostemplate
  password    = var.pm_root_password
  cores       = var.pm_cores
  memory      = var.pm_memory
  swap        = 512

  rootfs {
    storage = var.pm_storage
    size    = var.pm_disk_size
  }

  network {
  name   = "eth0"
  bridge = var.pm_bridge
  ip = "10.10.10.101/24,gw=10.10.10.1"
  type   = "veth"
  hwaddr = "02:00:00:01:02:03" # Static MAC address for simplicity
  }

  features {
    nesting = true
  }

  ssh_public_keys = file(var.pm_ssh_key_path)

  unprivileged = true

  tags = var.pm_tags
}

resource "null_resource" "setup" {
  depends_on = [proxmox_lxc.aws_lcx_docker_minimo]

  connection {
    type     = "ssh"
    host     = "10.10.10.101"  # IP estática
    user     = "root"
    password = var.pm_root_password
  }

  provisioner "remote-exec" {
    inline = [
      "apt update",
      "apt install -y docker.io",
      "systemctl enable docker --now"
    ]
  }
}