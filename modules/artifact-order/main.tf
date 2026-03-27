variable "name" {
  description = "name"
  type        = string
}

variable "images" {
  description = "image list"
  type        = list(string)
}

variable "charts" {
  description = "charts list"
  type        = list(string)
}

variable "arch" {
  description = "image arch"
  type        = string
}

output "demo_artifact_order" {
  value = {
    name   = var.name
    images = var.images
    charts = var.charts
    arch   = var.arch
  }
}

resource "terraform_data" "artifact_order" {
  input = {
    name   = var.name
    images = var.images
    charts = var.charts
    arch   = var.arch
  }
}
