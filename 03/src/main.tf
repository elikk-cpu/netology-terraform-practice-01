data "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

data "yandex_vpc_subnet" "web" {
  name = var.web_subnet_name
}

data "yandex_vpc_subnet" "db" {
  name = var.db_subnet_name
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}
