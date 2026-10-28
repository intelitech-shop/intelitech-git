variable "ssh_key_name" {
    description = "Name of the AWS key pair used for ec2 ssh access"
    type = string
}

variable "ssh_public_key" {
  description = "SSH public key content (PEM format)"
  type        = string
}

variable "ssh_ingress_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = string
}
