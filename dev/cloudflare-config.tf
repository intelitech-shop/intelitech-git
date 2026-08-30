resource "cloudflare_zero_trust_tunnel_cloudflared" "self_hosted_tunnel_intelitech" {
    account_id = var.cloudflare_account_id
    name = "api-local-dev"
    config_src = "cloudflare"
    tunnel_secret = var.tunnel_secret

}


resource "cloudflare_zero_trust_tunnel_cloudflared_config" "tunnel_config" {
    account_id = var.cloudflare_account_id
    tunnel_id = cloudflare_zero_trust_tunnel_cloudflared.self_hosted_tunnel_intelitech.id
    config = {
      ingress = [ {
        hostname = "dev.intelitech.shop"
        service = "http://0.0.0.0:3501"
      },
      {
        service = "http_status:404"
      } ]
    }
  
}

resource "cloudflare_dns_record" "dns_tunnel" {
    zone_id = var.cloudflare_zone_id
    name = "dev"
    content = "${cloudflare_zero_trust_tunnel_cloudflared.self_hosted_tunnel_intelitech.id}.cfargotunnel.com"
    type = "CNAME"
    ttl = 1
    proxied = true
  
}