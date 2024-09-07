variable "buckets" {
  type = map(any)
}

variable "acl_body" {
  type = map(any)
}

variable "tags" {
  type    = map(any)
  default = {}
}

resource "tencentcloud_cos_bucket" "this" {
  for_each                   = var.buckets
  bucket                     = "${each.key}-${local.app_id}"
  encryption_algorithm       = "AES256"
  enable_intelligent_tiering = true
  versioning_enable          = lookup(each.value, "versioning_enable", true)
  tags                       = var.tags
}
