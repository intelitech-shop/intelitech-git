output "compartment_id" {
  value = oci_identity_compartment.example_compartment.id
}

output "vm_public_ip" {
  value       = oci_core_instance.ic_pub_vm-A.public_ip
  description = "IP público da VM criada"
}