output "vm_public_ip" {
  value = aws_instance.web.public_ip
  description = "IP público da VM criada"
}