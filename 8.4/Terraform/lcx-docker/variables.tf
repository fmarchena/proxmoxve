variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}
variable "pm_target_node" {}
variable "pm_hostname" {}
variable "pm_ostemplate" {}
variable "pm_root_password" {}

variable "pm_cores" {
  type    = number
  default = 1
}
variable "pm_memory" {
  type    = number
  default = 1000
}
variable "pm_disk_size" {
  default = "10G"
}
variable "pm_storage" {
  default = "local-lvm"
}
variable "pm_bridge" {
  default = "vmbr1"
}
variable "pm_tags" {
  default = "community-script,docker,treedu,dev"
}
variable "pm_ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
}