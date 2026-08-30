variable "cloudflare_token" {
    type        = string
    description = "Cloudflare API token"
    sensitive   = true
}

variable "tunnel_secret" {
    type        = string
    description = "Auto-hosted tunnel secret (BASE64 DE 32 BYTES)"
    sensitive   = true
}

variable "cloudflare_account_id" {
    type        = string
    description = "Cloudflare Account ID"
    sensitive   = true
}

variable "cloudflare_zone" {
    type        = string
    description = "Dominio base"
  
}

variable "cloudflare_zone_id" {
    type        = string
    description = "Cloudflare Zone ID do dominio"
    sensitive   = true

}

variable "cloudflare_email" {
    type        = string
    description = "Email padrão de administração Cloudflare"
    sensitive   = true
  
}