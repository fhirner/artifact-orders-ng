locals {
  _raw_orders = {
    for f in fileset("${path.module}/orders", "*.yaml") :
    trimsuffix(f, ".yaml") => yamldecode(file("${path.module}/orders/${f}"))
  }

  artifact_orders = {
    for k, v in local._raw_orders : k => {
      images = lookup(v, "images", [])
      charts = lookup(v, "charts", [])
      arch   = lookup(v, "arch", "linux/amd64")
    }
  }
}

module "artifact_orders" {
  source = "./modules/artifact-order"

  for_each = local.artifact_orders

  name   = each.key
  images = each.value.images
  charts = each.value.charts
  arch   = each.value.arch
}
