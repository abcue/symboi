terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

provider "tencentcloud" {
  region = local.region
}

locals {
  region            = "ap-shanghai"
  availability_zone = "ap-shanghai-1"
  domain            = "tc.abcue.xyz"
  id_domain         = "id.${local.domain}"
  zones             = { for z in data.tencentcloud_private_dns_private_zone_list.id.private_zone_set : z.domain => z }
  # zone for resource id registry
  zone_id = local.zones[local.id_domain].zone_id
  # Usage
  # * local.ids["cluster-name.tke_cluster"]
  # * local.ids["cvm.tc.abcue.xyz.dns_zone"]
  ids    = { for r in data.tencentcloud_private_dns_records.id.record_set : r.sub_domain => r.record_value }
  app_id = data.tencentcloud_user_info.current.app_id
}

data "tencentcloud_user_info" "current" {}

# Resource registry
data "tencentcloud_private_dns_private_zone_list" "id" {
  filters {
    name   = "Domain"
    values = [local.id_domain]
  }
}

data "tencentcloud_private_dns_records" "id" {
  zone_id = local.zone_id
}
