variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "vm_db_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "vpc_name" {
  type    = string
  default = "develop"
}

variable "web_subnet_name" {
  type    = string
  default = "develop"
}

variable "db_subnet_name" {
  type    = string
  default = "develop-db"
}

variable "vm_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "web_vm_names" {
  type    = list(string)
  default = ["web-1", "web-2"]
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v1"
}

variable "vm_web_cores" {
  type    = number
  default = 2
}

variable "vm_web_memory" {
  type    = number
  default = 1
}

variable "vm_web_core_fraction" {
  type    = number
  default = 5
}

variable "vm_web_disk_volume" {
  type    = number
  default = 5
}

variable "vm_db_platform_id" {
  type    = string
  default = "standard-v3"
}

variable "vm_db_core_fraction" {
  type    = number
  default = 20
}

variable "vm_preemptible" {
  type    = bool
  default = true
}

variable "vm_nat" {
  type    = bool
  default = true
}

variable "vm_ssh_user" {
  type    = string
  default = "ubuntu"
}

variable "vm_serial_port_enable" {
  type    = string
  default = "1"
}

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))

  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 2
      disk_volume = 5
    },
    {
      vm_name     = "replica"
      cpu         = 4
      ram         = 4
      disk_volume = 6
    }
  ]
}
variable "storage_zone" {
  type    = string
  default = "ru-central1-e"
}

variable "storage_subnet_name" {
  type    = string
  default = "develop-storage"
}

variable "storage_cidr" {
  type    = list(string)
  default = ["10.0.3.0/24"]
}

variable "vm_storage_platform_id" {
  type    = string
  default = "standard-v3"
}

variable "vm_storage_cores" {
  type    = number
  default = 2
}

variable "vm_storage_memory" {
  type    = number
  default = 1
}

variable "vm_storage_core_fraction" {
  type    = number
  default = 20
}

variable "vm_storage_boot_disk_volume" {
  type    = number
  default = 5
}

variable "storage_disk_count" {
  type    = number
  default = 3
}

variable "storage_disk_size" {
  type    = number
  default = 1
}
