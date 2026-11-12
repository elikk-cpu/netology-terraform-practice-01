
# Storage subnet
resource "yandex_vpc_subnet" "storage" {
  name           = var.storage_subnet_name
  zone           = var.storage_zone
  network_id     = data.yandex_vpc_network.develop.id
  v4_cidr_blocks = var.storage_cidr
}

# Three additional disks
resource "yandex_compute_disk" "storage" {
  count = var.storage_disk_count

  name = "storage-disk-${count.index + 1}"
  size = var.storage_disk_size
  type = "network-hdd"
  zone = var.storage_zone
}

# Storage VM
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vm_storage_platform_id
  zone        = var.storage_zone

  resources {
    cores         = var.vm_storage_cores
    memory        = var.vm_storage_memory
    core_fraction = var.vm_storage_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_storage_boot_disk_volume
      type     = "network-hdd"
    }
  }

  scheduling_policy {
    preemptible = var.vm_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.storage.id
    nat                = var.vm_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.vm_serial_port_enable
    ssh-keys           = "${var.vm_ssh_user}:${local.ssh_public_key}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage

    content {
      disk_id = secondary_disk.value.id
    }
  }
}
