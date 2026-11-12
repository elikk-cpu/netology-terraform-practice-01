resource "local_file" "ansible_inventory" {
  filename = "${path.module}/hosts.ini"

  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = values(yandex_compute_instance.db)
    storage    = [yandex_compute_instance.storage]
  })

  file_permission = "0644"
}
