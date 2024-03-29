data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.response_body)
}

output "my_ip_addr" {
  value = local.ifconfig_co_json.ip
}
