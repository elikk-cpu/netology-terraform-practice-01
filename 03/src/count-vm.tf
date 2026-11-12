resource "yandex_compute_instance" "web" {
  count = length(var.web_vm_names)

  name        = var.web_vm_names[count.index]
  platform_id = var.vm_web_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_web_disk_volume
      type     = "network-hdd"
    }
  }

  scheduling_policy {
    preemptible = var.vm_preemptible
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.web.id
    nat                = var.vm_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.vm_serial_port_enable
    ssh-keys           = "${var.vm_ssh_user}:${local.ssh_public_key}"
  }

  depends_on = [
    yandex_compute_instance.db
  ]
}
