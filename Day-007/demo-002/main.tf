provider "publicip" {
  provider_url = "https://ifconfig.co/" # optional
  timeout      = "10s"                  # optional

  # 1 request per 500ms
  rate_limit_rate  = "500ms" # optional
  rate_limit_burst = "1"     # optional
}

terraform {
  required_providers {
    publicip = {
      source = "nxt-engineering/publicip"
      version = "~>0.0.7"
    }
  }
}

data "publicip_address" "default" {}

output "my_ip_address" {
  value = data.publicip_address.default.id
}
