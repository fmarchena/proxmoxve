locals {
  # Asume que vmid está definido como variable
  mac_prefix = "02" # Locally administered MAC

  mac_middle = format("%02x", var.vmid % 256)
  mac_end    = format("%02x:%02x:%02x", var.vmid % 256, var.vmid * 2 % 256, var.vmid * 3 % 256)

  generated_mac = "${local.mac_prefix}:${local.mac_middle}:${local.mac_end}"
}